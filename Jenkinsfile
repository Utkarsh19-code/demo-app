pipeline {
    agent any
    environment {
        APP_NAME = "demo-app"
        RELEASE = "1.0.0"
        DOCKER_USER = "utkarsh19"
        IMAGE_NAME = "${DOCKER_USER}" + "/" + "${APP_NAME}"
    }
    stages{
        stage("Cleanup Workspace"){
                steps {
                cleanWs()
                }
        }
        stage('Git checkout'){
            steps{
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'github', url: 'https://github.com/Utkarsh19-code/demo-app']])
            }
        }
        stage('Build docker image'){
            steps{
                script{
                    sh 'docker build -t ${IMAGE_NAME} .'
                }
            }
        }
        stage('Push to Dockerhub'){
            steps{
                script{
                    withCredentials([string(credentialsId: 'dockercred', variable: 'dockerpwd')]){
                        sh 'docker login -u utkarsh19 -p ${dockerpwd}'
                        sh 'docker push ${IMAGE_NAME}'
                    }
                }
            }
        }
        stage('Docker run'){
            steps{
                script{
                    sh 'docker run -d -p 3000:3000 ${IMAGE_NAME} '
                }
            }
        }
    }
    post {
        always{
            emailext(
            subject: "pipeline status: ${currentBuild.result}",
            body: '''<html>
                       <body>
                          <p> Build is ${currentBuild.result}</p>
                       </body>
                    </html> ''',
            to: 'ananda.yashaswi@quokkalabs.com','utkarsh19srvstv@gmail.com',
            from: 'utkarshsrvstv19@gmail.com',
            replyTo: 'utkarshsrvstv19@gmail.com',
            mimeType: 'text/html'
            )
        }
    }
}
