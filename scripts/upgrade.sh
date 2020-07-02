#!/bin/sh

# Docker compose upgrading script
# Execute this script with command
#   make mk-upgrade

RELEASE=https://github.com/$MK_REPO/archive/$MK_VERSION.tar.gz

# Downloading new release
echo "Downloading version $MK_VERSION from $RELEASE"
curl -Ls $RELEASE | tar zxfm - devilbox-docker-compose-makefile-$MK_VERSION/.mk-lib --strip-components=1
echo "Done"
