pipeline {
    agent any

    environment {
        ARM_CLIENT_ID       = credentials('AZURE_CLIENT_ID')
        ARM_CLIENT_SECRET   = credentials('AZURE_CLIENT_SECRET')
        ARM_TENANT_ID       = credentials('AZURE_TENANT_ID')
        ARM_SUBSCRIPTION_ID = credentials('AZURE_SUBSCRIPTION_ID')
    }

    stages {

        stage('Terraform Init') {
            steps {
                dir('azure') {
                    bat 'C:\\Terraform\\terraform.exe init'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir('azure') {
                    bat 'C:\\Terraform\\terraform.exe plan'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                dir('azure') {
                    bat 'C:\\Terraform\\terraform.exe apply -auto-approve'
                }
            }
        }
    }
}
