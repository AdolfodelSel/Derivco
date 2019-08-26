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
$ sudo docker-compose pull
```

If you never used docker swarm you have to initialize it

```
$ sudo docker swarm init
```

## Running the tests

You have two options to run the tests.

If you have mix installed you can run it directly,
but first you have to launch the database container.

```
$ cd to_test
$ sudo docker-compose up -d database
```

Then go back and run the mix command

```
$ cd ..
$ sudo DB_IP="localhost" mix test
```

If you dont have mix installed you can run these tests directly in a container

```
$ cd to_test
$ sudo docker-compose up
```

I launched all my servers with the remsh tool, so you can connect then easily with the command

```
$ sudo docker exec -it <CONTAINER ID> iex --name debug@127.0.0.1 --cookie "derivco_cookie" --remsh derivco@127.0.0.1
```

## Deployment

Before start the deployment, check the proxy section in the `docker-compose.yml` file,
just to be sure that the url to the `docker.sock` it is the same as in you pc.
It is very important because if is wrong the proxy will not work.

Examples of default routes:

  * Ubuntu (Windows Subsystem): `//var/run/docker.sock:/var/run/docker.sock`
  * Linux: `/var/run/docker.sock:/var/run/docker.sock`

Create the new stack with the docker-compose file

```
$ sudo docker stack deploy -c docker-compose.yml derivco
```

The deployment should be quicker but let it some seconds (~50s)

## API

Here you have a link to my public Postman workspace, there you will find the API documentation
and also some test results.

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