ARG BASE_IMAGE=docker:18.05.0-ce
FROM ${BASE_IMAGE}
VOLUME ["/srv/browser/data"]
ENTRYPOINT ["sh", "/opt/scripts/entrypoint.sh"]
CMD ["up"]