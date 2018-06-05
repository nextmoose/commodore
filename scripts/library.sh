#!/bin/sh

create-volume(){
    docker \
        volume \
        create \
        label "moniker=${1}" \
        label "type=primary" \
        label "expiry=${2}" \
        &&
    docker \
        volume \
        create \
        label "moniker=${1}" \
        label "type=snapshot" \
        label "interval=${3}" \
        &&
    true
}