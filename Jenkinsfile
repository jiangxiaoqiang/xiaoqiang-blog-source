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
                sh "npm install -g hexo"
                sh "hexo generate"
            }
        }
        
        stage('publish') {
            steps{
                sh "git config --global user.email \"jiangtingqiang@gmail.com\""
                sh "git config --global user.name \"jiangxiaoqiang\""
                withCredentials([usernamePassword(credentialsId: 'github-credential', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    script {
                        env.encodedPass=URLEncoder.encode(PASS, "UTF-8")
                    }
                    sh 'git checkout master'
                    sh 'git pull origin master'
                    sh 'git add .'
                    sh "git diff-index --quiet HEAD || git commit -m \"[docs] scheduled auto commit task\" || git push"
                    sh "git push https://${USER}:${encodedPass}@github.com/jiangxiaoqiang/xiaoqiang-blog-source.git"
                } 
            }
        }
    }
}