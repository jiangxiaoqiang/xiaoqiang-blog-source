pipeline {
    
    agent { 
        node {
            label 'jenkins-master'
        }
    }
    
    environment {
        NODEJS_HOME = "${tool 'NodeJS-14.7.0'}"
		PATH="${env.NODEJS_HOME}/bin:${env.PATH}"
    }
    
    tools {
        //maven 'maven-3'    //这里是全局工具配置的名字,要对应
        nodejs "NodeJS-14.7.0"     //这里是全局工具配置的名字,要对应
        //gradle "Gradle"      //这里是全局工具配置的名字,要对应
    }

    stages {
        stage('checkout-source') {
            steps {
                git credentialsId: 'gitlab-project-auth',
                url: 'https://github.com/jiangxiaoqiang/xiaoqiang-blog-source.git'
             } 
        }
        
        stage('build-source') {
            steps{
                sh "npm install"
                sh "npm install yarn"
                sh "yarn add hexo@4.1.1 hexo-cli@4.1.0"
                sh "hexo clean"
                sh "hexo generate"
                sh "rm -rf ${JENKINS_HOME}/workspace/jiangxiaoqiang.github.io/2020"
                sh "cp -r jiangxiaoqiang.github.io/* ${JENKINS_HOME}/workspace/jiangxiaoqiang.github.io"
            }
        }
        
    }
}