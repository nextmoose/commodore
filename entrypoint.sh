#!/bin/sh

while [ ${#} -gt 0 ]
do
    case ${1} in
        --project-name)
            export PROJECT_NAME="${2}" &&
                shift 2
        ;;
    esac
done &&
    cleanup(){
        sudo docker-compose stop &&
            sudo docker-compose rm -fv
    } &&
    sudo docker-compose up -d &&
    sh