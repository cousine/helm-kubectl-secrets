FROM alpine:3.8

# Metadata
LABEL org.label-schema.name="helm-kubectl-secrets" \
      org.label-schema.url="https://hub.docker.com/r/cousine/helm-kubectl-secrets/" \
      org.label-schema.vcs-url="https://github.com/cousine/helm-kubectl-secrets" 

# Note: Latest version of kubectl may be found at:
# https://aur.archlinux.org/packages/kubectl-bin/
ENV KUBE_LATEST_VERSION="v1.13.0-1"
# Note: Latest version of helm may be found at:
# https://github.com/kubernetes/helm/releases
ENV HELM_VERSION="v2.12.0"

RUN apk add --no-cache ca-certificates bash git \
    && wget -q https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/amd64/kubectl -O /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
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
