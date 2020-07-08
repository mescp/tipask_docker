#!/bin/bash

#获取源代码
git clone https://github.com/sdfsky/tipask.git src

#编译docker
docker build --pull --rm -f "Dockerfile" -t tipask:latest "."