#!/bin/sh

while [ ${#} -gt 0 ]
do
    case ${1} in
        --expiry)
            export EXPIRY=$(date --date "${2}" +%s) &&
                shift 2
        ;;
        --project-name)
            export PROJECT_NAME="${2}" &&
                shift 2
        ;;
        --browser-version)
            export BROWSER_VERSION="${2}" &&
                shift 2
        ;;
        --hacker-version)
            export HACKER_VERSION="${2}" &&
                shift 2
        ;;
        *)
            echo Unknown Option &&
                echo ${0} &&
                echo ${@} &&
                exit 64
        ;;
    esac
done &&
    if [ -z "${EXPIRY}" ]
    then
        export EXPIRY=$(date --date "now + 1 month" +%s)
    fi &&
    if [ -z "${PROJECT_NAME}" ]
    then
        export PROJECT_NAME="$(uuidgen)"
    fi &&
    if [ -z "${BROWSER_VERSION}" ]
    then
        export BROWSER_VERSION=0.0.0
    fi &&
    if [ -z "${HACKER_VERSION}" ]
    then
        export HACKER_VERSION=0.2.0
    fi &&
    export EXPIRY="${EXPIRY}" &&
    export PROJECT_NAME="${PROJECT_NAME}" &&
    export BROWSER_VERSION="${BROWSER_VERSION}" &&
    export HACKER_VERSION="${HACKER_VERSION}" &&
    cleanup(){
        sudo --preserve-env docker-compose stop &&
            sudo --preserve-env docker-compose rm -fv
    } &&
    trap cleanup EXIT &&
    env &&
    sudo --preserve-env docker-compose up -d &&
    sh