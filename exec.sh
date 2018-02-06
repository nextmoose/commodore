#!/bin/sh

sudo \
    docker \
    run \
    --interactive \
    --tty \
    --rm \
    --label expiry=$(($(date +%s)+60*60*24*7)) \
    docker:18.01.0-ce \
        container \
        run \
        --interactive \
        --tty \
        --rm \
        --label expiry=$(($(date +%s)+60*60*24*7)) \
        rebelplutonium/commodore:0.0.0