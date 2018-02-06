FROM docker/compose:1.18.0
RUN \
    adduser -D user && \
        echo "user ALL=(ALL) NOPASSWD: /usr/local/bin/docker-compose" > /etc/sudoers.d/user && \
        chmod 0444 /etc/sudoers.d/user
USER user
WORKDIR /home/user
COPY docker-compose.yml entrypoint.sh /home/user/
VOLUME /home
ENTRYPOINT ["sh", "/home/user/entrypoint.sh"]
CMD []