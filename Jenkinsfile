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
                sh 'clang -o main src/main.c'
            }
        }
	stage('Backup') {
            steps {
                script {
                    // Erstellt ein Backup der aktuellen main-Datei
                    sh '''
                    mkdir -p /Users/jay/jenkins-slave/backup
                    cp main /Users/jay/jenkins-slave/backup/main
                    '''
                    echo "Backup created."
                }
            }
        }
        stage('Test') {
            steps {
                // Führt das Testskript aus
                sh 'chmod +x test.sh && ./test.sh'
            }
        }
	stage('Deploy') {
            steps {
                script {
                    // Deployment auf das Zielsystem
                    sh '''
                    mkdir -p /Users/jay/jenkins-deploy
		    cp main /Users/jay/jenkins-deploy
		    cd /Users/jay/jenkins-deploy && ./main & 
                    '''
                }
            }
	}
  	// Überprüft, ob der Prozess vom  Programm nach dem Deployement erfolgreich im
	// Hintergrund läuft
	stage('Test Program Execution') {
            steps {
                script {
                    // Überwachung der Anwendung nach der Bereitstellung
                    def exitCode = sh(script: 'pgrep -f main', returnStatus: true)
                    if (exitCode != 0) {
                        error "Programm Excecution Failed with code  ${exitCode}"
                    } else {
                    	echo "Progam is running successfully!"
		    }
                }
            }
        }
    }// stages
    post {
        failure {
            // Rollback auf die vorherige Version, falls der Health-Check oder ein anderer Teil der Pipeline fehlschlägt
            stage('Rollback') {
                steps {
                    script {
                        // Rollback zu einer vorherigen Version im Jenkins-Slave-Verzeichnis
                        sh '''
                        # Annahme: Die vorherige Version befindet sich im Backup-Verzeichnis
                        cp /Users/jay/jenkins-slave/backup/main /Users/jay/jenkins-deploy/main
                        cd /Users/jay/jenkins-deploy && ./main &
                        '''
                        echo "Rollback executed: Previous version restored."
                    }
                }
            }
        }
    }	
}// pipeline

