#!/bin/bash

#获取源代码
if [ ! -d "docker/tipask" ]; then
    wget https://www.tipask.com/release/Tipask_v3.5.5_UTF8_20191017.zip -O docker/tipask.zip
    unzip docker/tipask.zip -d docker/tipask
fi

#拷贝卷结构
[ ! -d "volumes" ] && mkdir volumes
[ ! -d "volumes/tipask" ] && cp -r docker/tipask/v3.5.5 ./volumes/tipask

#编译docker
docker build --pull --rm -f "docker/Dockerfile" -t tipask:latest "./docker"

if 
