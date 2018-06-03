#!/bin/sh

docker container stop browser &&
    docker container rm --recursive --force browser &&
    docker volume rm &&