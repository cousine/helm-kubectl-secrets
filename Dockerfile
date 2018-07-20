FROM dtzar/helm-kubectl

ARG VCS_REF
ARG BUILD_DATE

# Metadata
LABEL org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.name="helm-kubectl-secrets" \
      org.label-schema.url="https://hub.docker.com/r/cousine/helm-kubectl-secrets/" \
      org.label-schema.vcs-url="https://github.com/cousine/helm-kubectl-secrets" \
      org.label-schema.build-date=$BUILD_DATE

RUN apk update && apk add --no-cache ca-certificates curl gnupg

RUN mkdir -p /usr/local/helm/plugins
ENV HELM_HOME /usr/local/helm
RUN helm plugin install https://github.com/futuresimple/helm-secrets

RUN mkdir /root/keys

COPY docker-entrypoint.sh /usr/local/bin
ENTRYPOINT ["docker-entrypoint.sh"]

ENV GPG_TTY=/dev/console
CMD bash
