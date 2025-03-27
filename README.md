# Restaurant Management system

Application used in order to simulate restaurant and people in it for them to order dishes / plates. Actually it's a small application created that is having a small docker-compose that contains only one container named db that is the database of this application which is a relationnal database (PostgreSQL).

## db folder

Inside of the container folder resides the db folder. That is a mount point for the docker in order to keep persisting the tables / schemas / types of the database. Using this folder "db" we can then run the container with small amount of data to test the application I am about to do.