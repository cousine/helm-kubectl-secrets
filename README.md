# Helm-Kubernetes + Helm-Secrets Docker hub image

[![Build Status](https://travis-ci.org/cousine/helm-kubectl-secrets.svg?branch=master)](https://travis-ci.org/cousine/helm-kubectl-secrets)

## Overview

This image is adds to [dtzar/helm-kubectl](https://hub.docker.com/r/dtzar/helm-kubectl)
[Helm Secrets](https://github.com/futuresimple/helm-secrets) plugin.

This image is useful to build continuos deployment jobs that can work with encrypted
secrets in your helm charts.

## Run

Just like [dtzar/helm-kubectl](https://hub.docker.com/r/dtzar/helm-kubectl), you
can directly run helm:

```
docker run --rm cousine/helm-kubectl-secrets \
  helm install -f values.yaml stable/mariadb
```

Better yet, you can leverage [Helm Secrets](https://github.com/futuresimple/helm-secrets) 
and use `helm-wrapper` which automatically decrypts all encrypted files within the chart
at installation then cleans it up once the installation process is complete:

```
docker run --rm cousine/helm-kubectl-secrets \
  helm-wrapper install -f encrypted_values.yaml stable/mariadb
```

### Supplying keys

To use [Helm Secrets](https://github.com/futuresimple/helm-secrets) you'll need to import
keys into the gpg keyring or setup the correct ENV variables (if you are using GCP KMS for example).

**Helm-Kubernetes + Helm-Secrets** will automatically import `.gpg` keys within `/root/keys`, so
all you've to do is mount your key location to `/root/keys`:

```
docker run -it -v ~/your-keys-folder:/root/keys cousine/helm-kubectl-secrets \
  helm-wrapper install -f encrypted_values.yaml stable/mariadb
```

#### GCP KMS

If you are using GCP KMS, you can place your json key and mount it to the container
like the previous step, then define the `GOOGLE_APPLICATION_CREDENTIALS` environment
variable to point to your key:
 
```
docker run -it -v ~/your-gcp-key-folder:/root/keys cousine/helm-kubectl-secrets \
  -e GOOGLE_APPLICATION_CREDENTIALS='/root/keys/YOUR_KEY_FILENAME' \
  helm-wrapper install -f encrypted_values.yaml stable/mariadb
```


