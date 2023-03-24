pipeline {
  agent {
    node {
      label 'iac'
    }

  }
  stages {
    stage('Checkout') {
      steps {
        checkout(scm: [$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/teammira2023/mira-iac.git']]], poll: true)
      }
    }

    stage('IAC Code Quality Check') {
      steps {
        sh '''sonar-scanner \\
  -Dsonar.projectKey=MIRA-IAC \\
  -Dsonar.sources=. \\
  -Dsonar.host.url=http://52.206.217.129:9000 \\
  -Dsonar.login=sqp_c663f5cd123ed04885e4c9c1a426feb3d07b40d7'''
      }
    }

    stage('Environment Build') {
      steps {
        sh 'chmod +x mya.sh'
        sh 'chmod +x mytina.sh'
        sh 'cat mya.sh'
        sh 'cat mytina.sh'
      }
    }

    stage('terraform init') {
      steps {
        sh 'echo $AWS_ACCESS_KEY_ID'
        sh 'echo $AWS_SECRET_ACCESS_KEY'
        sh 'echo $AWS_SESSION_TOKEN'
        sh './mya.sh'
      }
    }

    stage('terraform in Action') {
      steps {
        sh 'echo $AWS_ACCESS_KEY_ID'
        sh 'echo $AWS_SECRET_ACCESS_KEY'
        sh 'echo $AWS_SESSION_TOKEN'
        sh './mytina.sh'
      }
    }

  }
}
