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
                sh "ls -alh"
                sh "cd .."
                sh "ls -alh" 
                sh "cd ../xiaoqiang-blog-source"
                sh "npm install"
                sh "npm install -g hexo"
                sh "hexo generate"
            }
        }
        
        
    }
}