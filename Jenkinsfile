def myCheckout(myGitUrl, myBranch, myLocalDir) {
    checkout changelog: false, poll: false, scm: [$class: 'GitSCM',
    branches: [[name: myBranch]],
    doGenerateSubmoduleConfigurations: false,
    extensions: [[$class: 'RelativeTargetDirectory',
    relativeTargetDir: myLocalDir]],
    submoduleCfg: [],
    userRemoteConfigs: [[credentialsId: 'GithubSSH',
    url: myGitUrl]]
    ]
}
node() {
    stage('clone the git') {
        echo "Cloning git"
        def parthak8_url = "git@github.com:ParthaK8/dockerizing-nodejs"
        def parthak8_branch = "*/nodejs-app-code"
        def local_dir = ""
        myCheckout(parthak8_url, parthak8_branch, local_dir)

        // set an environment variable, value of local_dir
        env.LOCAL_DIR = local_dir
        // Verify
        sh "ls -la"
        sh "ls -la ${LOCAL_DIR}"
        sh "chmod 666 Dockerfile"
        def CWDABSPATH
        CWDABSPATH = sh (
        script: "echo `pwd`",
                returnStdout: true
        ).trim()
        println "Current Working Directory: " + CWDABSPATH
        env.BASEPATH = CWDABSPATH  // set env var for BASEPATH
    }

    stage('Build image') {
            app = docker.build("parthakaushik/addressbook_app")
    }
    stage('Test image') {
    app.inside {
             sh 'echo "Tests passed"'
            }
    }
    stage('Push image') {
    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub') {
        app.push("${env.BUILD_NUMBER}")
        app.push("latest")
       }
    }
}

