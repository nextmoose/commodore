#!/bin/sh

BROWSER_VOLUME=$(docker \
    volume \
    create \
    --label "volume.expiration=never" \
    --label "snapshot.expiry=now" \
    --label "snapshot.interval=1s" \
    --label "snapshot.dependency=browser" \
    --label "archive.00.expiry=now + 1 week" \
    --label "archive.00.interval=monthly" \
    --label "archive.01.expiry=now" \
    --label "archive.01.interval=weekly" \
    --label "archive.02.expiry=now" \
    --label "archive.02.interval=daily" \
    --label "archive.03.expiry=now" \
    --label "archive.03.interval=hourly" \
    ) &&
    docker \
        container \
        create \
        --name browser \
        --privileged \
        --mount type=volume,source=${BROWSER_VOLUME},destination=/data,readonly=false \
        --mount type=bind,source=/tmp/.X11-unix,destination=/tmp/.X11-unix,readonly=true \
        --mount type=bind,source=/srv/pulse,destination=/run/user/${TARGET_UID}/pulse,readonly=false \
        --mount type=bind,source=/etc/machine-id,destination=/etc/machine-id,readonly=false \
        --mount type=bind,source=/var/run/dbus/system_bus_socket,destination=/var/run/dbus/system_bus_socket,readonly=false \
        --mount type=bind,source=/var/lib/dbus,destination=/var/lib/dbus,readonly=false \
        --shm-size 256m \
        --env DISPLAY \
        --env TARGET_UID \
        --env XDG_RUNTIME_DIR=/run/user/${TARGET_UID} \
        urgemerge/chromium-pulseaudio@sha256:21d8120ff7857afb0c18d4abf098549de169782e652437441c3c7778a755e46f \
            http://inner:10604
    