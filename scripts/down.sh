#!/bin/sh

source /opt/scripts/monikers.sh &&
    docker \
        container \
        stop \
        $(docker container ls --quiet --filter label=${BROWSER_CONTAINER}) \
        &&
    docker \
        container \
        rm \
        $(docker container ls --quiet --filter label=${BROWSER_CONTAINER}) \
        &&
    docker volume rm $(docker volume ls --quiet --filter label=moniker=${BROWSER_DATA_VOLUME})&&