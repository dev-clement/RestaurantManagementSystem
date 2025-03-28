# Container

The container folder contains all what is needed to configure and run the database through the run.bat script. Actually the run.bat script is doing a simple call to the docker-compose, magic will happened inside of this docker-compose,

## docker-compose

The docker-compose has only one service, this service is the database of the application (being a PostgreSQL), I didn't use a nosql because there is no because, I just thought that using SQL database with typing is easier than using a NoSQL that can be a way more bigger and heavier than a simple SQL database. Of course I could have make use of MariaDB or MySQL, but I have already work with those datbases and I wanted to work with a database that I knew it was great, but I've never work with it, so now it is !

### Services

As said before, there is only one services, this service is the database of the application. This application is pulled from the docker-hub site, where all the public repositories for docker resides. When selecting the docker image, you can see in the docker-compose file that the image is postgres:alpine. Actually the image name is postgres, the column are here to separate the image name and the tag from the postgresql. 

#### Image versions

In docker, let's say that one application is using postgresql that has been done a long time ago, but since this period, postgresql kept update the database and the engine of it. Does that means the application using postgresql has to update itself each time the postgre database gets updated ? Well if it was the case, I would have stop working in it, perhaps I would have became a garbage collector ! The point being, docker did a smart thing, it did something to handle versions of the image.

Image has a plenty of versions, some are more appropriate than the other depending on your needs, in this project, I wanted a small image, with the strict minimum into it. That's why I picked the alpine version of postgres. And if you want to check the versions that docker-hub has for pulling, you can check it in the docker-hub repository over here [in docker-hub]

[in docker-hub]: https://hub.docker.com/search?q=postgres

#### container_name

Once you find the image in the docker-hub, you can take a look at the container_name. The value ser in the container_name will be the name of the image that will be present inside the docker desktop or in the CLI when typing command such as `docker container ls` it will list all the running containers, and if you want to show all the containers (started or stop) you can also do `docker container ls -a` and if you want to see all the container running using something else you can do `docker ps` using ps you can also do `docker ps -a` to see all the containers.

#### environment

This part of the file will define all the environment variables created for te container to run, load and being configured correctly, using the PostgreSQL image, there are some environment variables to take into account such as:
* POSTGRES_USER : <user name of the database lies here>
* POSTGRES_PASSWORD : <password of the user database lies here>

If you want to know more about the environment variables of your choosen image, or the postgre image, a good things is to look at the documentation [in docker-hub].

#### volumes

Here comes the fun part, and the reasons why I really like docker (looking for a joke about it, but I didn't find any, seems like it's just a fact, I like docker !) we know (or not) that docker let users create a container that is an isolated dependency from your own OS, it is using the kernel of the host, but everything that is happening in the container will not need to be present in the host machine (dependency let say). For instance you can make a container that is using postgresql without having postgre on your host machine !

Actually ok we know that a container can have things inside (dependency) that the host machine cannot modify or even persist. Does that means that if the docker is down, the entire content of the container is removed with it ? Basically yes it is ! HOWEVER you can use volume in order to make some peristence of the content of your container through the host. For instance, once you've the container, perhaps you want to pass a script that will initialize everything in it. There is several ways to do so, one of my favorite way that doesn't requires to create a Dockerfile that is just inheriting from a docker file [in docker-hub] is using the docker-compose file. A docker-compose.yml file is a yaml file with a yaml syntax to configure a suite of container, which is done to fetch the image, configure it and then run it using the `CMD` or the `ENTRYPOINT` of the dockerfile.

But here we're talking about volume, why saying all the gibberish about image, dependency, persistence and so on. You'll see volume using docker-compose is really cool !!

##### volumes in service

From what I know about, you can create two types of volumes:
1. volumes in service
2. volumes outside service

Volumes in service is volume where the persistence happens ! For instance, let say you want to save the database while you are running it in order to keep the users of your application (if for instance, you want to make an ecommerce application, you don't want to remove the entire database because of a crash in the container !), but you can save it to your host machine using a simple line:

```yaml
volumes:
  - ./db/:/var/lib/postgresql/data/
```

Inside of the service / image, you can specify a volume in order to persist the data from the postgresql container, that means each time you start the container through a `docker-compose up`, all the data of your folder (here the `/var/lib/postgresql/data`) will be kept from your host and once the container will be restart, the container itself will look at the folder you define before the column (here `./db`), but that's not the only way to do that, you can also do something like this

```yaml
services:
    db:
        # content of the image
        # configuration
        volumes:
            - postgresql_data:/var/lib/postgresql/data/
volumes:
    postgresql_data:
```

What will happens then is that the db service present in the docker-compose will have a volume named `postgresql_data` that is pointing to somewhere (only docker knows) and it will store what is inside the `/var/lib/postgresql/data` folder.

#### network

By default, a container has a network, and if not configured, all the container present in the docker-compose have the same network. By default a container doesn't have any network connection (like which network the container is attached to), or whether their peers are also Docker workloads or not. A container only sees a network interface with netorks details (IP address, routing table, DNS services).

But you can create user-defined network, and connect multiple containers to the same network. Once a container is connected to the network, the container will be able to communicate with each other using container IP address or container names. For the postgre container, I have created a network (which seems useless as there is no container in the docker-compose other the postgresql one)