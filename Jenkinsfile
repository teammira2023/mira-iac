pipeline {
  agent any
  stages {
    stage('SonarScan') {
      steps {
        sh '''sonar-scanner \\
  -Dsonar.projectKey=easy-school \\
  -Dsonar.sources=. \\
  -Dsonar.host.url=http://52.206.217.129:9000 \\
  -Dsonar.login=sqp_6d19651cb884b94fbe78e7d5f43e8921d4ea7aa8'''
      }
    }

  }
}