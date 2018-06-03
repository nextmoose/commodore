ARG BASE_IMAGE=docker:18.05.0-ce
FROM ${BASE_IMAGE}
COPY scripts /opt/
ENTRYPOINT ["sh", "/opt/scripts/entrypoint.sh"]
CMD ["up"]