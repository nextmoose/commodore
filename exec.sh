#!/bin/sh

IDS=$(mktemp -d) &&
	cleanup(){
		docker rm -fv $(cat ${IDS}/docker) $(cat ${IDS}/commodore) &&
		docker network rm $(cat ${IDS}/network) &&
		rm -rf ${IDS}
	} &&
	trap cleanup exit &&
	sudo \
		--preserve-env \
		docker \
		create \
		--cidfile ${IDS}/docker \
		--volume /:/srv/host:ro \
		--volume /var/run/docker.sock:/var/run/docker.sock:ro \
		--volume /tmp/.X11-unix:/tmp/.X11-unix:ro
		--privileged \
		docker:18.01.0-ce-dind \
			--host tcp://0.0.0.0:2376 &&
	sudo \
		--preserve-env \
		docker \
        create \
		--cidfile ${IDS}/commodore \
        --interactive \
        --tty \
        --env DISPLAY \
		--env DOCKER_HOST=tcp://docker:2376 \
        --label expiry=$(($(date +%s)+60*60*24*7)) \
        rebelplutonium/commodore:0.0.0 \
            "${@}" &&
	sudo --preserve-env docker network create $(uuidgen) > ${IDS}/network &&
	sudo \
		--preserve-env \
		docker \
		network \
		connect \
		--alias docker \
		$(cat ${IDS}/network) \
		$(cat ${IDS}/docker) &&
	sudo \
		--preserve-env \
		docker \
		network \
		connect \
		$(cat ${IDS}/network) \
		$(cat ${IDS}/commodore) &&
	sudo --preserve-env docker start $(cat ${IDS}/docker) &&
	sudo --preserve-env docker start --interactive $(cat ${IDS}/commodore)
