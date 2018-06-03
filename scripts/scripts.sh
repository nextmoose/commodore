#!/bin/sh

create-volume(){
    docker \
        volume \
        create \
        label moniker=${1} \
        label type=primary \
        &&
    docker \
        volume \
        create \
        label moniker=${1} \
        label type=snapshot \
        &&
    docker \
        volume \
        create \
        label moniker=${1} \
        label type=archive \
        &&
    true
}