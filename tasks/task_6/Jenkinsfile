pipeline {
    environment {
        AWS_ACCOUNT_ID = '897722688515'
        AWS_REGION = 'eu-central-1'
        AWS_CREDENTIALS = credentials('44111b14-2d97-4a93-9fb4-f90af7ea49a0')
        REPO_NAME = 'hello-spring-k8s'
        IMAGE_TAG = 'latest'
        SONAR_TOKEN = credentials('5d5a7c70-257f-4af0-8a20-6548cb508f34')
        AWS_ECR = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/task-6-repository"
        KUBECONFIG = credentials('99dcec1f-026b-4cce-adb7-54b9e87b2e92')
        EMAIL = 'askhatecc@gmail.com'
    }
    agent {
        kubernetes {
            yaml '''
            apiVersion: v1
            kind: Pod
            spec:
              imagePullSecrets:
                - name: ecr-secret
              containers:
              - name: maven
                image: maven:3.8.5-openjdk-17-slim
                imagePullPolicy: IfNotPresent
                command:
                - cat
                tty: true
              - name: kaniko
                image: gcr.io/kaniko-project/executor:debug
                imagePullPolicy: IfNotPresent
                command:
                - /busybox/cat
                tty: true
              - name: helm
                image: alpine/helm:latest
                imagePullPolicy: IfNotPresent
                command:
                - /bin/sh
                tty: true
            '''
        }
    }

    stages {
        stage('Git Clone') {
            steps {
                container('maven') {
                    git branch: 'main', url: 'https://github.com/askhat-zab/repo.git'
                }
            }
        }
        stage('Install Dependencies') {
            steps {
                container('maven') {
                    sh '''
                    cd $REPO_NAME
                    mvn -ntp clean install -B -Dmaven.test.skip=true
                    mvn -ntp package -B -Dmaven.test.skip=true
                    '''
                }
            }
        }
        stage('Run Tests') {
            steps {
                container('maven') {
                    sh '''
                    cd $REPO_NAME
                    mvn -ntp clean test -B
                    '''
                }
            }
        }
        stage('SonarQube Analysis') {
            steps {
                container('maven') {
                    sh '''
                    cd $REPO_NAME
                    mvn -ntp -B sonar:sonar -Dsonar.projectKey=askhat-zab_repo \
                                    -Dsonar.host.url=https://sonarcloud.io \
                                    -Dsonar.login=$SONAR_TOKEN \
                                    -Dsonar.organization=askhat-zab
                    '''
                }
            }
        }
        stage('Build Docker Image') {
            input {
                message "Build Docker Image?"
            }
            steps {
                container('kaniko') {
                    sh """
                    cd $REPO_NAME
                    /kaniko/executor --snapshot-mode=redo --context `pwd` --dockerfile Dockerfile --destination $AWS_ECR:$IMAGE_TAG --cleanup
                    """
                }
            }
        }
        stage('Upgrade Application using Helm') {
            steps {
                container('helm') {        
                    sh '''
                    cp $KUBECONFIG kube_config
                    helm repo add askhat-zab https://askhat-zab.github.io/repo/helm/charts
                    helm repo update
                    helm upgrade --install task-6-hello-spring-k8s askhat-zab/task-6-hello-spring-k8s \
                        --namespace task-6 \
                        --create-namespace \
                        --kubeconfig kube_config \
                        --set service.type=NodePort \
                        --set image.repository=$AWS_ECR \
                        --set image.tag=$IMAGE_TAG \
                        --atomic
                    '''
                }
            }
        }
        stage('Smoke Test') {
            steps {
                container('helm') {
                    sh '''
                    apk add --no-cache curl
                    curl -s https://hello.itcorp.uk/actuator/health
                    '''
                }
            }
        }
    }

    post {
        always {
            echo 'This will always run'
        }
        success {
            echo 'This will run only if successful'
            mail bcc: '', 
                body: "<b>Pipeline Success</b><br>Project: ${env.JOB_NAME} <br>Build Number: ${env.BUILD_NUMBER} <br>URL: ${env.BUILD_URL}", 
                cc: '', 
                charset: 'UTF-8', 
                from: '', 
                mimeType: 'text/html', 
                replyTo: '', 
                subject: "SUCCESS CI: Project -> ${env.JOB_NAME}", 
                to: "${env.EMAIL}"
        }
        failure {
            echo 'This will run only if Pipeline Failed'
            mail bcc: '', 
                body: "<b>Pipeline Failed</b><br>Project: ${env.JOB_NAME} <br>Build Number: ${env.BUILD_NUMBER} <br>URL: ${env.BUILD_URL}", 
                cc: 'ganesh_1@mail.com', 
                charset: 'UTF-8', 
                from: '', 
                mimeType: 'text/html', 
                replyTo: '', 
                subject: "ERROR CI: Project -> ${env.JOB_NAME}", 
                to: "${env.EMAIL}"
        }
    }
}