#!/bin/bash

echo -e "\e[32mInitializing mariadb..."
docker stop xrengine_db
docker rm xrengine_db
docker-compose up