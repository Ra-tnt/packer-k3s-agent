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
    AWS_PROFILE="kh-labs"
  }
  stages {
    stage("plan") {
          steps {
                  sh '''
		  docker run -it -d \
	          --env TF_NAMESPACE=$$TF_NAMESPACE \
                  --env OWNER=$$OWNER \
                  -v /var/run/docker.sock:/var/run/docker.sock \
                  -v $$PWD:/$$basename $$PWD \
                  -v k3s_packer:/token \
                  -w /$$basename $$PWD \
                  --name $$basename $$PWD \
                  --hostname $$basename $$PWD \
                  bryandollery/terraform-packer-aws-alpine
		  '''
          }
      }

    
      stage("build") {
          steps {
              container('packer') {
                  sh 'packer build packer.json'
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
