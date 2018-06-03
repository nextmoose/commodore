#!/bin/sh

case ${1} in
    up)
        sh /opt/scripts/up.sh &&
            exit 0
    ;;
    down)
        sh /opt/scripts/down.sh &&
            exit 0
    ;;
    *)
        echo Unknown Option &&
            echo ${0} &&
            echo ${@} &&
            exit 64
    ;;
esac