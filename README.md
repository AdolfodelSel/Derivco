# Derivco

## Prerequisites

  * Install Docker: https://docs.docker.com/install/
  * Install Docker-compose: https://docs.docker.com/compose/install/

## Run

  * Download the code `git clone https://github.com/AdolfodelSel/Derivco.git`
  * Go to Derivco folder `cd Derivco`
  * Here you have two options:
    1. Run `docker-compose pull` and you will download the needed images.
    2. Run `docker-compose build` and `docker pull dockercloud/haproxy` and `mariadb:10.1.41`
  * Create the docker swarm `docker swarm init`
  * Maybe you will have to change the volme path of the proxy service:
    - Windows: //var/run/docker.sock:/var/run/docker.sock
    - Linux: /var/run/docker.sock:/var/run/docker.sock
  * Create the stack `docker stack deploy -c docker-compose.yml derivco`

Now you can visit [`localhost`](http://localhost) from your browser.

## API

  * Visit my postman workspace: https://documenter.getpostman.com/view/6788500/SVfJWCbR