pipeline {
    agent any

    stages {
        stage('Fetch Code') {
            steps {
                // Holt den Quellcode aus dem Git-Repository
                checkout scm
            }
        }
        stage('Build') {
            steps {
                // Baut das C-Programm auf macOS mit Clang
                sh 'clang -o main main.c'
            }
        }
        stage('Test') {
            steps {
                // Führt das Testskript aus
                sh 'chmod +x test.sh && ./test.sh'
            }
        }
    }
}

