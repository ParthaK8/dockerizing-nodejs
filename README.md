# dockerizing-nodejs
This is some sample code for creating a Docker image of a nodejs app in a Jenkins pipeline and pushing it to a docker registry.

See the following stage in the Jenkinsfile:
    stage('Build image') {
            app = docker.build("parthakaushik/addressbook_app")
    }

Replace the docker-registry and image name with your own.

Examine the line in the Jenkinsfile that pushes the image:
    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub')

The string 'dockerhub' is the ID of a username/password credential in Jenkins that stores the credentials to the docker registry to be used.
