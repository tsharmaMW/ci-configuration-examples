pipeline {
    agent none
    triggers {
        githubPush()
    }
    stages {
        stage('Compile and test MEX on matrix agents') {
            matrix {
                axes {
                    axis {
                        name 'OS'
                        values 'linux', 'windows'
                    }
                }
                stages {
                    stage("Compile and test MEX") {
                        agent { label "${OS}" } // Assumes you have labels corresponding to the OS types
                        steps {
                            script {
                                matlabver = tool 'R2023b'
                                if (isUnix()) {
                                    env.PATH = "${matlabver}/bin:${env.PATH}"   // Linux or macOS agent
                                } else {
                                    env.PATH = "${matlabver}\\bin;${env.PATH}"   // Windows agent
                                }  
                                echo "Running on ${OS}"
                                runMATLABBuild(tasks: 'mex test')
                                junit testResults: 'test-results/results.xml', skipPublishingChecks: true
                                stash includes: 'toolbox/*.mex*', name: "${OS}MexFile"
                            }
                        }
                    }
                    
                }
            }
        }
        stage('Create and release toolbox') {
            agent { label 'linux' }
            environment {
                GITHUB_TOKEN = credentials('github-token') // Assumes you've stored your GitHub token as a Jenkins credential
            }
            tools {
                matlab 'R2023b'
                git 'Default'
            }
            steps {
                script {
                    // Loop through agents to unstash files
                    def agents = ['linux', 'windows']
                    agents.each { agentLabel ->
                        // Define stash name based on agent label
                        def stashName = "${agentLabel}MexFile"
                        echo "Unstashing ${stashName}"
                        unstash stashName
                    }
                }
                sh "ls -la ${pwd()}/toolbox"
                runMATLABBuild(tasks: 'packageToolbox')
                script {
                    // Create release
                    def name = "Cross-Platform Array Product Toolbox"
                    def repoOwner = "tsharmaMW"
                    def repoName = "ci-configuration-examples"
                    def createReleaseCmd = """curl -XPOST -H "Authorization: Bearer ${GITHUB_TOKEN}" --data "{\\"tag_name\\": \\"v1.${env.BUILD_NUMBER}.3\\", \\"name\\": \\"${name}\\"}" https://api.github.com/repos/${repoOwner}/${repoName}/releases"""
                    def release = sh(script: createReleaseCmd, returnStdout: true).trim()
                    def id = release.tokenize(',')[0].replaceAll(/[^0-9]/, '')

                    // Upload the artifact
                    def artifactPath = "toolbox.mltbx"
                    sh """curl -XPOST -H "Authorization:token ${GITHUB_TOKEN}" -H "Content-Type:application/octet-stream" --data-binary @${artifactPath} https://uploads.github.com/repos/${repoOwner}/${repoName}/releases/${id}/assets?name=toolbox.mltbx"""
                }
                echo 'Release successfully created on GitHub'
            }
        }
    } 
}