pipeline {
  agent {
    kubernetes {
      yaml """
apiVersion: v1
kind: Pod
metadata:
  labels:
    some-label: some-label-value
spec:
  containers:
  - name: packer
    image: hashicorp/packer 
    command: 
    - bash
    tty: true
"""
    }
  }
  environment {
    CREDS = credentials('theta_aws_creds')
    AWS_ACCESS_KEY_ID = "${CREDS_USR}"
    AWS_SECRET_ACCESS_KEY = "${CREDS_PSW}"
    OWNER = 'theta-team'
    PROJECT_NAME = 'web-server'
  }
  stages {
    stage("plan") {
          steps {
              sh 'make all'
          }
      }

    
      stage("build") {
          steps {
              container('packer') {
                  sh 'build'
              }
          }
      }
  }
post {
    success {
        build quietPeriod: 0, wait: false, job: 'theta-tf'
    }
  }
  
}
