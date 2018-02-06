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
        sudo --preserve-env docker-compose stop &&
            sudo --preserve-env docker-compose rm -fv
    } &&
    trap cleanup EXIT &&
    sudo --preserve-env docker-compose up -d &&
    sh