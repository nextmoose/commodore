#!/bin/sh

echo exec HELLO ${@} &&
sudo \
    --preserve-env \
    docker \
    run \
    --interactive \
    --tty \
    --rm \
    --env DISPLAY \
    --volume /var/run/docker.sock:/var/run/docker.sock:ro \
    --label expiry=$(($(date +%s)+60*60*24*7)) \
    docker:18.01.0-ce \
        container \
        run \
        --interactive \
        --tty \
        --rm \
        --env DISPLAY \
        --mount type=bind,source=/var/run/docker.sock,destination=/var/run/docker.sock,readonly=true \
        --label expiry=$(($(date +%s)+60*60*24*7)) \
        rebelplutonium/commodore:0.0.0 \
            "${@}"