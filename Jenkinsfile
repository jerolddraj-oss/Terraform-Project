pipeline {
    agent any

    stages {

        stage('Checkout Code') {
            steps {
                git 'https://github.com/jerolddraj-oss/Terraform-Project.git'
            }
        }

        stage('Terraform Init') {
            steps {
                withCredentials([azureServicePrincipal('jenkins-sp')]) {
                    dir('azure') {
                        bat '''
                        set ARM_CLIENT_ID=%servicePrincipalId%
                        set ARM_CLIENT_SECRET=%servicePrincipalKey%
                        set ARM_TENANT_ID=%tenantId%
                        set ARM_SUBSCRIPTION_ID=%subscriptionId%

                        terraform init
                        '''
                    }
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                withCredentials([azureServicePrincipal('jenkins-sp')]) {
                    dir('azure') {
                        bat 'terraform plan'
                    }
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                withCredentials([azureServicePrincipal('jenkins-sp')]) {
                    dir('azure') {
                        bat 'terraform apply -auto-approve'
                    }
                }
            }
        }
    }
}