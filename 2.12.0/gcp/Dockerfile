FROM google/cloud-sdk:228.0.0-alpine

# Metadata
LABEL org.label-schema.name="helm-kubectl-secrets" \
      org.label-schema.url="https://hub.docker.com/r/cousine/helm-kubectl-secrets/" \
      org.label-schema.vcs-url="https://github.com/cousine/helm-kubectl-secrets" 

ENV HELM_VERSION="v2.12.0"

RUN gcloud components install kubectl \
    && wget -q http://storage.googleapis.com/kubernetes-helm/helm-${HELM_VERSION}-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm \
    && chmod +x /usr/local/bin/helm

WORKDIR /config

RUN apk add --no-cache curl gnupg

ENV HELM_HOME=/usr/local/helm
RUN mkdir -p /usr/local/helm/plugins \
    && helm plugin install https://github.com/futuresimple/helm-secrets \
    && mkdir /root/keys

COPY docker-entrypoint.sh /usr/local/bin
ENTRYPOINT ["docker-entrypoint.sh"]

ENV GPG_TTY=/dev/console
CMD bash
