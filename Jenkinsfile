pipeline {
    agent { label 'master' }
    stages {
        stage('Build do pacote') {
            agent { docker { image 'maven:3.3.3' } }
            steps {
                sh 'mvn -B -DskipTests clean install'
            }
        }
        stage('Teste do código') {
            agent { docker { image 'maven:3.3.3' } }
            steps {
                sh 'mvn test'
            }
            post {
                always {
                    junit 'target/surefire-reports/*.xml' 
                }
            }
        }    
        stage('Criando novo servidor na AWS') {
            steps {
                sh 'ansible-playbook -i inventory playbook.yml'
            }
        }
        stage('Deploy do pacote no novo servidor') {
            steps {
                sh 'ansible-playbook -i inventory_new playbook_new.yml'
            }
        }
    }
}

