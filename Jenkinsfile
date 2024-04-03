def agents = ['linux', 'windows']

def generateStage(nodeLabel) {
    return {
        def matlabver
        stage("Runs on ${nodeLabel}") {
            node(nodeLabel){
                matlabver = tool 'R2023b'
                if (isUnix()) {
                    env.PATH = "${matlabver}/bin:${env.PATH}"   // Linux or macOS agent
                } else {
                    env.PATH = "${matlabver}\\bin;${env.PATH}"   // Windows agent
                }  
                echo "Running on ${nodeLabel}"
                runMATLABBuild(tasks: 'mex test')
                junit testResults: 'test-results/results.xml', skipPublishingChecks: true
                stash includes: 'toolbox/*.mex*', name: "${nodeLabel}MexFile"
            }
        }
    }
}

def parallelStagesMap = agents.collectEntries {
    ["${it}" : generateStage(it)]
}

pipeline {
    agent none
    triggers {
        githubPush()
    }
    stages {
        stage('Create and test blah blah mex files') {
            steps {
                script {
                    parallel parallelStagesMap
                }
            }
        }
        stage('Package and blah release blah toolbox') {
            agent {
                label 'linux'
            }
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
                    agents.each { agentLabel ->
                        // Define stash name based on agent label
                        def stashName = "${agentLabel}MexFile"
                        echo "Unstashing ${stashName}"
                        unstash stashName
                    }
                }
                sh "ls -la ${pwd()}/toolbox"
                runMATLABBuild(tasks: 'packageToolbox')
                // create release
                script {
                    def name = "Cross-Platform Array Product Toolbox"
                    def repoOwner = "tsharma"
                    def repoName = "ci-configuration-examples"
                    def createReleaseCmd = """curl -XPOST -H "Authorization:token ${GITHUB_TOKEN}" --data "{\\"name\\": \\"${name}\\"}" https://api.github.com/repos/${repoOwner}/${repoName}/releases"""
                }
                echo 'Run after successful completion of previous stage'
                
            }
        }
    } 
}