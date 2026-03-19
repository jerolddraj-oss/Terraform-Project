pipeline {
    agent any

    parameters {
        choice(name: 'CLOUD', choices: ['azure', 'aws', 'gcp'], description: 'Select Cloud')
        choice(name: 'ENV', choices: ['dev', 'prod', 'qa'], description: 'Select Environment')
        choice(name: 'ACTION', choices: ['apply', 'destroy'], description: 'Terraform Action')
    }

    environment {
        ARM_CLIENT_ID       = credentials('AZURE_CLIENT_ID')
        ARM_CLIENT_SECRET   = credentials('AZURE_CLIENT_SECRET')
        ARM_TENANT_ID       = credentials('AZURE_TENANT_ID')
        ARM_SUBSCRIPTION_ID = credentials('AZURE_SUBSCRIPTION_ID')
    }

    stages {

        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                script {
                    def path = "jd-multicloud-terraform/${params.CLOUD}/env/${params.ENV}"
                    dir(path) {
                        bat 'C:\\Terraform\\terraform.exe init'
                    }
                }
            }
        }

        stage('Terraform Apply') {
            when {
                expression { params.ACTION == 'apply' }
            }
            steps {
                script {
                    def path = "jd-multicloud-terraform/${params.CLOUD}/env/${params.ENV}"
                    dir(path) {
                        bat 'C:\\Terraform\\terraform.exe apply -auto-approve'
                    }
                }
            }
        }

        stage('Terraform Destroy') {
            when {
                expression { params.ACTION == 'destroy' }
            }
            steps {
                script {
                    def path = "jd-multicloud-terraform/${params.CLOUD}/env/${params.ENV}"
                    dir(path) {
                        bat 'C:\\Terraform\\terraform.exe destroy -auto-approve'
                    }
                }
            }
        }
    }
}
