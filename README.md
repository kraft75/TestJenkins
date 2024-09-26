This is a Jenkins Pipeline test,

Steps of the Pipeline

Fetch Code: Retrieves the source code from your Git repository.
Build: Builds the C program (main) with Clang.
Backup: Creates a backup of the main file in the directory /Users/jay/jenkins-slave/backup/.
Test: Executes the test script.
Deploy: Copies the main file to the deployment directory and starts the program in the background.
Test Program Execution: Checks whether the program is running.
Rollback: If something fails, the previous version is restored from the backup.






