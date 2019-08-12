node('worker') {
    stage('Preparation') {
        git branch: 'uzubtsou', url: 'https://github.com/MNT-Lab/build-t00ls'
    }

    stage('Building code') {
        withMaven(jdk: 'java-8u221', maven: 'maven_auto_3.6.1', mavenSettingsConfig: 'maven-proxy-v2') {
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

    stage('Testing') {
          parallel(
              'pre-integration-test':{
                sh 'cd helloworld-project/helloworld-ws/ &&  ' +
                'mvn pre-integration-test'
              },
              'integration-test':{
                sh 'cd helloworld-project/helloworld-ws/ &&  ' +
                'mvn integration-test'
              },
              'post-integration-test':{
                sh 'cd helloworld-project/helloworld-ws/ &&  ' +
                'mvn integration-test'
              }
          )
    }

    stage('Triggering job and fetching artefact after finishing') {
    // some block
    }

    stage('Packaging and Publishing results') {
    // some block
    }

    stage('Asking for manual approva') {
    // some block
    }

    stage('Deployment (rolling update, zero downtime)') {
    // some block
    }
}