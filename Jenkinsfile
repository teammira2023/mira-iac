pipeline {
  agent {
    node {
      label 'iac'
    }

  }
  stages {
    stage('IAC Code Quality Check') {
      steps {
        sh '''sonar-scanner \\
  -Dsonar.projectKey=MIRA-IAC \\
  -Dsonar.sources=. \\
  -Dsonar.host.url=http://52.206.217.129:9000 \\
  -Dsonar.login=sqp_c663f5cd123ed04885e4c9c1a426feb3d07b40d7'''
      }
    }

  }
}
