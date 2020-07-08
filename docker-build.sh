#!/bin/bash

#获取源代码
[ ! -d "docker/tipask" ] && git clone https://github.com/sdfsky/tipask.git docker/tipask
#拷贝卷结构
[ ! -d "volumes" ] && mkdir volumes
[ ! -d "volumes/storage" ] && cp -r src/storage ./volumes/storage
[ ! -d "volumes/bootstrap" ] && cp -r src/bootstrap ./volumes/bootstrap
touch volumes/.env
#编译docker
docker build --pull --rm -f "docker/Dockerfile" -t tipask:latest "./docker"

