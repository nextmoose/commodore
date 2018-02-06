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
        --gpg-secret-key)
            export GPG_SECRET_KEY="${2}" &&
                shift 2
        ;;
        --gpg2-secret-key)
            export GPG2_SECRET_KEY="${2}" &&
                shift 2
        ;;
        --gpg-owner-trust)
            export GPG_OWNER_TRUST="${2}" &&
                shift 2
        ;;
        --gpg2-owner-trust)
            export GPG2_OWNER_TRUST="${2}" &&
                shift 2
        ;;
        --gpg-key-id)
            export GPG_KEY_ID="${2}" &&
                shift 2
        ;;
        --secret-organization)
            export SECRET_ORGANIZATION="${2}" &&
                shift 2
        ;;
        --secret-repository)
            export SECRET_REPOSITORY="${2}" &&
                shift 2
        ;;
        --browser-version)
            export BROWSER_VERSION="${2}" &&
                shift 2
        ;;
        --docker-version)
            export DOCKER_VERSION="${2}" &&
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
    if [ -z "${GPG_SECRET_KEY}" ]
    then
        echo You must provide a GPG SECRET KEY &&
            exit 65
    fi &&
    if [ -z "${GPG2_SECRET_KEY}" ]
    then
        echo You must provide a GPG2 SECRET KEY &&
            exit 66
    fi &&
    if [ -z "${GPG_OWNER_TRUST}" ]
    then
        echo You must provide a GPG OWNER TRUST &&
            exit 67
    fi &&
    if [ -z "${GPG2_OWNER_TRUST}" ]
    then
        echo You must provide a GPG2 OWNER TRUST &&
            exit 68
    fi &&
    if [ -z "${GPG_KEY_ID}" ]
    then
        echo You must provide a GPG KEY ID &&
            exit 69
    fi &&
    if [ -z "${SECRET_ORGANIZATION}" ]
    then
        echo You must provide a SECRET ORGANIZATION &&
            exit 70
    fi &&
    if [ -z "${SECRET_REPOSITORY}" ]
    then
        echo You must provide a SECRET REPOSITORY &&
            exit 71
    fi &&
    if [ -z "${BROWSER_VERSION}" ]
    then
        export BROWSER_VERSION=0.0.0
    fi &&
    if [ -z "${DOCKER_VERSION}" ]
    then
        export DOCKER_VERSION=18.01.0-dind
    fi &&
    if [ -z "${HACKER_VERSION}" ]
    then
        export HACKER_VERSION=0.2.0
    fi &&
    export EXPIRY="${EXPIRY}" &&
    export PROJECT_NAME="${PROJECT_NAME}" &&
    export GPG_SECRET_KEY="${GPG_SECRET_KEY}" &&
    export GPG2_SECRET_KEY="${GPG2_SECRET_KEY}" &&
    export GPG_OWNER_TRUST="${GPG_OWNER_TRUST}" &&
    export GPG2_OWNER_TRUST="${GPG2_OWNER_TRUST}" &&
    export GPG_KEY_ID="${GPG_KEY_ID}" &&
    export SECRET_ORGANIZATION="${SECRET_ORGANIZATION}" &&
    export SECRET_REPOSITORY="${SECRET_REPOSITORY}" &&
    export BROWSER_VERSION="${BROWSER_VERSION}" &&
    export DOCKER_VERSION="${DOCKER_VERSION}" &&
    export HACKER_VERSION="${HACKER_VERSION}" &&
    cleanup(){
        sudo --preserve-env docker-compose stop &&
            sudo --preserve-env docker-compose rm -fv
    } &&
    trap cleanup EXIT &&
    env &&
    sudo --preserve-env docker-compose up -d &&
    sh