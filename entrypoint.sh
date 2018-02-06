#!/bin/sh

while [ ${#} -gt 0 ]
do
    case ${1} in
        --expiry)
            export EXPIRY=$(date --date "${2}") &&
                shift 2
        ;;
        --project-name)
            export PROJECT_NAME="${2}" &&
                shift 2
        ;;
    esac
done &&
    if [ ! -z "${EXPIRY}" ]
    then
        export EXPIRY=$(date --date "now + 1 month")
    fi &&
    cleanup(){
        sudo --preserve-env docker-compose stop &&
            sudo --preserve-env docker-compose rm -fv
    } &&
    trap cleanup EXIT &&
    sudo --preserve-env docker-compose up -d &&
    sh