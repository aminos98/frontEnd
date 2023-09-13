pipeline {
    agent any
    stages {
        stage('Build npm') {
            steps {
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/aminos98/frontEnd']])
                sh 'npm install'
                sh 'npm run build --prod'
            }
        }
        stage('Build docker image'){
            steps{
                script{
                    sh 'docker build -t front-end .'
                }
            }
        }
        stage('Push image to DockerHub') {
            steps {
                script {
                    withCredentials([
                        usernamePassword(credentialsId: 'docker-hub-repo', usernameVariable: 'USER', passwordVariable: 'PWD')
                        ]){
                             sh "docker login -u $USER -p $PWD"
                             sh "docker tag front-end:latest ahmedamin1998/front-end:latest"
                             sh "docker push ahmedamin1998/front-end:latest"
                        }
                }
            }
        }
        stage('Deploy to Minikube') {
            agent any
            steps {
                script {
                    // Define the Kubernetes configuration credentials
                    def kubeconfigCredentialId = 'mykubeconfig'
                    // Use withCredentials to set KUBECONFIG from the credential file
                    withCredentials([file(credentialsId: kubeconfigCredentialId, variable: 'KUBECONFIG')]) {
                        sh "kubectl apply -f /home/amine/frontEnd/Kubernetes/angular-app-deployment.yaml"
                    }
                }
            }
        }
    }
    
}            