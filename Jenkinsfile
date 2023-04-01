#!/usr/bin/env groovy
pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION = "us-east-1"
    }
    stages {
        stage("Create an EKS Cluster") {
            steps {
                script {
                    dir('terraform') {
                        sh "terraform init"
                        sh "terraform apply -auto-approve"
                    }
                }
            }
        }
           stage('build') {
            steps {
                    withCredentials([usernamePassword(credentialsId: 'mostafa', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                        sh """
                            docker login -u $USERNAME -p $PASSWORD
                            docker build -t mostafa001/challenge-app:${BUILD_NUMBER} .
                            docker push mostafa001/challenge-app:${BUILD_NUMBER}
                            echo ${BUILD_NUMBER} > ../bakehouse-build-number.txt
                        """
                    }
                    
                
            }
        }
            stage("Deploy to EKS") {
                steps {
                    script {
                        sh """
                            aws eks update-kubeconfig --name demo
                            export BUILD_NUMBER=\$(cat ../bakehouse-build-number.txt)
                            mv Deployment/app-py.yaml Deployment/app-py.yaml.tmp
                            cat Deployment/app-py.yaml.tmp | envsubst > Deployment/app-py.yaml
                            rm -f Deployment/app-py.yaml.tmp
                            kubectl apply -f Deployment 
                        """
                        
                    }
                }
            }
    }
}
