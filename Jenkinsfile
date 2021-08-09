#!groovy

pipeline {
    parameters {
    password (name: 'AWS_ACCESS_KEY_ID')
    password (name: 'AWS_SECRET_ACCESS_KEY')
  }
  environment {
    TF_WORKSPACE = 'dev' 
    TF_IN_AUTOMATION = 'true'
    AWS_ACCESS_KEY_ID = "${params.AWS_ACCESS_KEY_ID}"
    AWS_SECRET_ACCESS_KEY = "${params.AWS_SECRET_ACCESS_KEY}"
  }
  agent none
    stage('Docker Build') {
      agent any
      steps {
        sh 'docker build -t skeeterx/app:latest .'
      }
    }
    stage('Docker Push') {
      agent any
      steps {
        withCredentials([usernamePassword(credentialsId: 'dockerHub', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
          sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}"
          sh 'docker push skeeterx/app:latest'
        }
      }
    }
    stage ('Deploy') {
      steps {
        script{
          aws eks --region $(region) update-kubeconfig --name $(cluster_name)
          helm install app chart/ --values chart/values.yaml -n app --create-namespace
        }
      }
    }    
  }
}
