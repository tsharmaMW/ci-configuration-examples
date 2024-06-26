pipeline {
    agent none
    stages {
        stage('Compile and test MEX on matrix agents') {
            matrix {
                axes {
                    axis {
                        name 'OS'
                        values 'linux', 'windows', 'macos'
                    }
                }
                stages {
                    stage("Compile and test MEX") {
                        agent { label "${OS}" } // Assumes you have labels corresponding to the OS types
                        tools {
                            matlab 'R2024a'
                        }
                        steps {
                            script {
                                runMATLABBuild(tasks: 'mex test')
                                junit testResults: 'test-results/results.xml', skipPublishingChecks: true
                                stash includes: 'toolbox/*.mex*', name: "mex-${OS}"
                            }
                        }
                    }
                    
                }
            }
        }
        stage('Create and release toolbox') {
            agent { label 'linux' }
            environment {
                GITHUB_TOKEN = credentials('github-token') // Store your GitHub token as a Jenkins credential
            }
            tools {
                matlab 'R2024a'
            }
            steps {
                script {
                    // Loop through agents to unstash files
                    def agents = ['linux', 'windows', 'macos']
                    agents.each { OS ->
                        unstash "mex-${OS}"
                    }
                }
                runMATLABBuild(tasks: 'packageToolbox')
                script {
                    sh "gh release create v1.${env.BUILD_NUMBER}.0 toolbox.mltbx --title 'Cross-Platform Array Product Toolbox' --repo https://github.com/tsharmaMW/ci-configuration-examples"
                }
            }
        }
    } 
}