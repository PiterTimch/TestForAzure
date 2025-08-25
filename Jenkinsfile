pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                sh 'dotnet build TestForAzure.sln'
            }
        }

        stage('Test') {
            steps {
                sh 'dotnet test TestForAzure.Tests/TestForAzure.Tests.csproj'
            }
        }

        stage('Deploy') {
            when {
                anyOf {
                    branch 'develop'
                    branch 'main'
                }
            }
            steps {
                script {
                    if (env.BRANCH_NAME == 'develop') {
                        sh './deploy.sh develop'
                    } else if (env.BRANCH_NAME == 'main') {
                        sh './deploy.sh production'
                    }
                }
            }
        }
    }
}
