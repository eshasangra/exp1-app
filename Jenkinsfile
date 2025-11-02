pipeline {
    agent any

    environment {
        IMAGE_NAME = "esha-node-app"
        IMAGE_TAG  = "v1"
        CONTAINER_NAME = "node-container"
        APP_PORT = "3000"
    }

    stages {

        stage('Checkout') {
            steps {
                echo "Cloning repository from SCM..."
                checkout scm
            }
        }

        stage('Install Dependencies') {
            steps {
                echo "Installing Node modules..."
                sh 'npm install'
            }
        }

        stage('Run Tests') {
            steps {
                echo "Running tests..."
                sh 'npm test'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Building Docker image..."
                sh 'docker build -t $IMAGE_NAME:$IMAGE_TAG .'
            }
        }

        stage('Deploy Container') {
            steps {
                echo "Stopping old container if it exists..."
                sh '''
                    if [ "$(docker ps -q -f name=$CONTAINER_NAME)" != "" ]; then
                        docker stop $CONTAINER_NAME && docker rm $CONTAINER_NAME
                    elif [ "$(docker ps -aq -f name=$CONTAINER_NAME)" != "" ]; then
                        docker rm $CONTAINER_NAME
                    fi
                '''

                echo "Starting new container..."
                sh 'docker run -d -p 3000:3000 --name $CONTAINER_NAME $IMAGE_NAME:$IMAGE_TAG'
            }
        }
    }

    post {
        success {
            echo "✅ Pipeline Success: App is live on port ${APP_PORT}"
        }
        failure {
            echo "❌ Pipeline Failed. Check console logs."
        }
    }
}
