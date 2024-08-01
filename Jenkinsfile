pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                // Checkout the code from GitHub
                git 'https://github.com/kraft75/TestJenkins.git'
            }
        }
        stage('Build') {
            steps {
                // Kompiliere das Programm aus der C-Datei
                sh 'gcc -o build/output src/main.c'
            }
        }
        stage('Test') {
            steps {
                script {
                    // Fuehre das Programm aus und ueberpruefe die Ausgabe
                    def output = sh(script: 'build/output', returnStdout: true).trim()
                    if (output != 'Hello, Embedded Linux World!') {
                        error "Test failed: Unexpected output: ${output}"
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
                sh """
                echo "Deploying to the Docker test container..."
                // Kopiere das kompilierte Programm in den Docker-Container
                docker cp build/output test-container:/usr/share/nginx/html
                """
            }
        }
    }
    post {
        always {
            // Bereinige nach Abschluss der Pipeline
            cleanWs()
        }
    }
}
