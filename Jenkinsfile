node('worker') {
    stage('Preparation') {
        git branch: 'uzubtsou', url: 'https://github.com/MNT-Lab/build-t00ls'
    }

    stage('Building code') {
        withMaven(jdk: 'java-8u221', maven: 'maven_auto_3.6.1', mavenSettingsConfig: 'custom-maven-setting') {
            sh 'mvn -f helloworld-project/helloworld-ws/pom.xml clean install -U'
        }
    }

    stage('Sonar scan') {
        // https://docs.sonarqube.org/latest/analysis/scan/sonarscanner-for-jenkins/
        def scannerHome = tool 'SonarScanner'
        withSonarQubeEnv() {  // Will pick the global server connection you have configured
            sh "${scannerHome}/bin/sonar-scanner"
        }
    }
    probably need some tuning over here

    stage('Testing') {
        parallel(
            'pre Integration': {
              withMaven(jdk: 'java-8u221', maven: 'maven_auto_3.6.1', mavenSettingsConfig: 'custom-maven-setting') {
              sh 'cd helloworld-project/helloworld-ws/ &&  ' +
              'mvn pre-integration-test'
              }
            },
            'integration': {
              withMaven(jdk: 'java-8u221', maven: 'maven_auto_3.6.1', mavenSettingsConfig: 'custom-maven-setting') {
              sh 'cd helloworld-project/helloworld-ws/ &&  ' +
              'mvn integration-test'
              }
            },
            'post integration': {
              withMaven(jdk: 'java-8u221', maven: 'maven_auto_3.6.1', mavenSettingsConfig: 'custom-maven-setting') {
              sh 'cd helloworld-project/helloworld-ws/ &&  ' +
              'mvn post-integration-test'
              }
            }
        )
    }

  stage('Triggering job and fetching artefact after finishing') {
        jobDsl removedConfigFilesAction: 'DELETE', 
        removedJobAction: 'DELETE', 
        removedViewAction: 'DELETE',
        scriptText: '''job(\'MNTLAB-${student}-child-pip-job\') {
            git branch: 'uzubtsou', url: 'https://github.com/MNT-Lab/d192l-module'
            steps {
                shell("echo 'Hello World'")
            }
            }'''
        copyArtifacts filter: 'output.txt', projectName: 'MNTLAB-${student}-child-pip-job'
    }

    stage('Packaging and Publishing results') {
        'Create archieve': {
            sh 'tar -czf helloworld-${BUILD_NUMBER}.tar.gz -C helloworld-project/helloworld-ws/target helloworld-ws.war'
            archiveArtifacts 'helloworld-${BUILD_NUMBER}.tar.gz'
            nexusPublisher nexusInstanceId: 'nexus-k8s', nexusRepositoryId: 'maven-releases', packages: ['helloworld-${BUILD_NUMBER}.tar.gz']
        }
    }

    stage('Asking for manual approva') {
    // some block
    }

    stage('Deployment (rolling update, zero downtime)') {
    // some block
    }
}