pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                // Holt den Code aus dem GitHub-Repository
                git 'https://github.com/kraft75/TestJenkins.git'
            }
        }
        stage('Build') {
            steps {
                sh 'echo "Building the project..."'
                // Erstellt das execute-Verzeichnis, falls es nicht existiert
                sh 'mkdir -p execute'
                // Kompiliert die C-Datei in eine ausführbare Datei
                sh 'gcc -o execute/output.out src/main.c'
                // Erstellt das Testskript
                sh '''
                echo "#!/bin/bash" > execute/test.sh
                echo "./output.out > output.txt" >> execute/test.sh
                echo "if grep -q \"Hello, Embedded Linux World!\" output.txt; then" >> execute/test.sh
                echo "    echo \"Test passed.\"" >> execute/test.sh
                echo "    exit 0" >> execute/test.sh
                echo "else" >> execute/test.sh
                echo "    echo \"Test failed.\"" >> execute/test.sh
                echo "    exit 1" >> execute/test.sh
                echo "fi" >> execute/test.sh
                chmod +x execute/test.sh
                '''
            }
        }
        stage('Test') {
            steps {
                script {
                    // Führt das Testskript aus und überprüft die Ausgabe
                    def result = sh(script: 'execute/test.sh', returnStatus: true)
                    if (result != 0) {
                        error "Test failed"
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
                sh '''
                echo "Deploying to the Docker test container..."
                // Kopiert die kompilierte Datei in den Test-Container
                docker cp execute/output.out test-container:/usr/share/nginx/html
                // Kopiert das Testskript in den Test-Container, wenn es notwendig ist
                docker cp execute/test.sh test-container:/usr/share/nginx/html
                '''
            }
        }
        stage('Production Deployment') {
            steps {
                sh '''
                echo "Deploying to Docker test container..."
                //Simuliert die Bereitstellung auf einem Produktionsserver
                docker cp execute/output.out test-container:/usr/share/nginx/html
                // Das Testskript auf dem Test-Container ausführen
                docker exec test-container /usr/share/nginx/html/test.sh
                '''
            }
        }
        stage('Monitor') {
            steps {
                sh '''
                echo "Monitoring deployment..."
                //Beispiel-Befehl für Monitoring-Tools oder Benachrichtigungen
                //berprüft, ob die Anwendung im Test-Container erreichbar ist
                docker exec test-container curl -f http://localhost || echo 'Application not reachable'
                '''
            }
        }
    }
    post {
        always {
            // Bereinigt den Arbeitsbereich nach Abschluss der Pipeline
            cleanWs()
        }
        success {
            // Beispiel-Benachrichtigung bei erfolgreicher Ausführung
            echo 'Pipeline executed successfully!'
        }
        failure {
            // Beispiel-Benachrichtigung bei Fehlschlägen
            echo 'Pipeline failed!'
        }
    }
}
