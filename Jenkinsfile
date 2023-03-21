pipeline {
  agent any
  stages {
    stage('SonarScan') {
      steps {
        sh '''sonar-scanner \\
  -Dsonar.projectKey=MIRA-IAC \\
  -Dsonar.sources=. \\
  -Dsonar.host.url=http://52.206.217.129:9000 \\
  -Dsonar.login=sqp_976552446ff7fe3ab5542da9b19f1663c2c0d5dc'''
      }
    }

  }
}