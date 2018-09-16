#!/bin/bash
set -e

gpg --allow-secret-key-import --import /root/keys/*.gpg

exec "$@"
