# Derivco

Elixir application that serves football results.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine.
See deployment for notes on how to deploy the project on a live system.

* [GiHub](https://github.com/AdolfodelSel/Derivco) - Proyect code
* [DockerHub](https://hub.docker.com/r/adolfodelsel/derivco) - Proyect container
* [PostMan](https://documenter.getpostman.com/view/6788500/SVfJWCbR) - Proyect API

### Prerequisites

  Install Docker: https://docs.docker.com/install/

  ```
  $ sudo apt-get update
  $ sudo apt-get install apt-transport-https ca-certificates curl software-properties-common 
  $ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - 
  $ sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
  $ sudo apt-get update
  $ sudo apt-get install docker-ce
  ```

  Install Docker-compose: https://docs.docker.com/compose/install/

  ```
  $ sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  $ sudo chmod +x /usr/local/bin/docker-compose
  ```

### Installing

A step by step series of examples that tell you how to get a development env running

Download the code

```
git clone https://github.com/AdolfodelSel/Derivco.git
```

Go to Derivco folder

```
cd Derivco
```

Download the images

```
docker-compose pull
```

Alternatively you can build your own image instead of download it.
It is up to you, but i recommend to use the pull command.

  Build the image from the downloaded code

  ```  
  $ docker-compose build
  ```

  Download haproxy and mariadb image

  ```
  $ docker pull dockercloud/haproxy
  $ docker pull mariadb:10.1.41
  ```

## Running the tests

  Aun faltan

### Break down into end to end tests

Explain what these tests test and why

```
Give an example
```

## Deployment

If you never used docker swarm you have to initialize it

```
$ docker swarm init
```

Create the new stack with the docker-compose file

```
$ docker stack deploy -c docker-compose.yml derivco
```

The deployment should be quicker but let it some seconds(~50s)

Now you can make the API requests

Please check the proxy section in the `docker-compose.yml` file, just to be sure 
that the url to the `docker.sock` it is same as in you pc.
It is very important because if is wrong the proxy will not work.

Examples of default routes:

  * Windows Subsystem for Linux: `//var/run/docker.sock:/var/run/docker.sock`
  * Linux: `/var/run/docker.sock:/var/run/docker.sock`

## API

Here you have a link to my public Postman workspace, if you click it you will find the API documentation and also with some test results.

https://documenter.getpostman.com/view/6788500/SVfJWCbR

## Built With

* [Phoenix](https://phoenixframework.org/) - The framework used
* [GiHub](https://github.com/) - Used to store the poryect code
* [DockerHub](https://hub.docker.com/) - Used to store the created images
* [PostMan](https://www.getpostman.com/) - Used to create the API tests

## Author

* **Adolfo del Sel Llano**

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details