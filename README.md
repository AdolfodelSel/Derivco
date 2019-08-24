# Derivco

## Prerequisites

  * Install Docker: https://docs.docker.com/install/
  * Install Docker-compose: https://docs.docker.com/compose/install/

## Technologies

  * GitHub to store the proyect:
    https://github.com/AdolfodelSel/Derivco

  * DockerHub to store the proyect container:
    https://hub.docker.com/r/adolfodelsel/derivco

  * PostMan to make API tests and his documentation:
    https://documenter.getpostman.com/view/6788500/SVfJWCbR

## Install

  * Download the code :
  `git clone https://github.com/AdolfodelSel/Derivco.git`
  * Go to Derivco folder:
  `cd Derivco`
  * Download the images:
  `docker-compose pull`

  Alternatively you can build your own image instead of download it. It is up to you,
  but i recommend to download it.
    - `docker-compose build`
    - `docker pull dockercloud/haproxy`
    - `mariadb:10.1.41`

## Docker

  * If you never used docker swarm you have to initialize it:
  `docker swarm init`
  * Create the new stack with the docker-compose file:
  `docker stack deploy -c docker-compose.yml derivco`

  The deployment should be quicker but let it some seconds, 
  you can check if all the services are ready with the command: `docker service ls`

  Please check the proxy section on the `docker-compose.yml` file, just to be sure 
  that the url to the `docker.sock` it is same as in you pc.
  It is very important because if is wrong the proxy will not work.

  Default routes:
    - Windows Subsystem for Linux:
    `//var/run/docker.sock:/var/run/docker.sock`
    - Linux: 
    `/var/run/docker.sock:/var/run/docker.sock`

## Browser

  * Now you can visit [`localhost`](http://localhost) from your browser.