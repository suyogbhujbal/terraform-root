// ============================================================
//  Jenkinsfile — Simple Terraform Pipeline
//  Runs Init → Plan → Apply for DEV, UAT, and PROD
// ============================================================

pipeline {

    agent any

    environment {
    //    AWS_ACCESS_KEY_ID     = credentials('aws-access-key-id')
    //    AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
        AWS_DEFAULT_REGION    = 'us-east-1'
    }

    stages {

        // ── Checkout ──────────────────────────────────────────
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        // ══════════════════════════════════════════════════════
        //  DEV
        // ══════════════════════════════════════════════════════
        stage('DEV - Terraform Init') {
            steps {
                sh '''
                    echo "==> Initialising for DEV"
                    terraform init -reconfigure -input=false
                    terraform workspace select dev || terraform workspace new dev
                '''
            }
        }

        stage('DEV - Terraform Plan') {
            steps {
                sh '''
                    echo "==> Planning for DEV"
                    terraform plan -var-file="envs/dev.tfvars" -out="tfplan-dev" -input=false
                '''
            }
        }

        stage('DEV - Terraform Apply') {
            steps {
                sh '''
                    echo "==> Applying for DEV"
                    terraform apply -input=false -auto-approve "tfplan-dev"
                '''
            }
        }

        // ══════════════════════════════════════════════════════
        //  UAT
        // ══════════════════════════════════════════════════════
        stage('UAT - Terraform Init') {
            steps {
                sh '''
                    echo "==> Initialising for UAT"
                    terraform init -reconfigure -input=false
                    terraform workspace select uat || terraform workspace new uat
                '''
            }
        }

        stage('UAT - Terraform Plan') {
            steps {
                sh '''
                    echo "==> Planning for UAT"
                    terraform plan -var-file="envs/uat.tfvars" -out="tfplan-uat" -input=false
                '''
            }
        }

        stage('UAT - Approval') {
            steps {
                input message: 'Approve UAT deployment?', ok: 'Deploy to UAT'
            }
        }

        stage('UAT - Terraform Apply') {
            steps {
                sh '''
                    echo "==> Applying for UAT"
                    terraform apply -input=false -auto-approve "tfplan-uat"
                '''
            }
        }

        // ══════════════════════════════════════════════════════
        //  PROD
        // ══════════════════════════════════════════════════════
        stage('PROD - Terraform Init') {
            steps {
                sh '''
                    echo "==> Initialising for PROD"
                    terraform init -reconfigure -input=false
                    terraform workspace select prod || terraform workspace new prod
                '''
            }
        }

        stage('PROD - Terraform Plan') {
            steps {
                sh '''
                    echo "==> Planning for PROD"
                    terraform plan -var-file="envs/prod.tfvars" -out="tfplan-prod" -input=false
                '''
            }
        }

        stage('PROD - Approval') {
            steps {
                input message: 'Approve PROD deployment?', ok: 'Deploy to PROD'
            }
        }

        stage('PROD - Terraform Apply') {
            steps {
                sh '''
                    echo "==> Applying for PROD"
                    terraform apply -input=false -auto-approve "tfplan-prod"
                '''
            }
        }

    }

    post {
        always {
            sh 'rm -f tfplan-dev tfplan-uat tfplan-prod || true'
        }
        success {
            echo 'All environments deployed successfully!'
        }
        failure {
            echo 'Pipeline failed — check the logs above.'
        }
    }

}
