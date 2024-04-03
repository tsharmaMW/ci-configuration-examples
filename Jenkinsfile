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
            tools {
                matlab 'R2023b'
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
                echo 'Run after successful completion of previous stage'
                // create release
            }
        }
    } 
}