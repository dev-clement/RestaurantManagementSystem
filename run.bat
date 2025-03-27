@echo off
cd .\container\
docker-compose down
docker system prune --all --force
docker-compose up -d
pause