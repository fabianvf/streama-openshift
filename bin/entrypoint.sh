#!/bin/bash -e

# This is documented here:
# https://docs.openshift.com/container-platform/3.10/creating_images/guidelines.html#openshift-specific-guidelines

if ! whoami &>/dev/null; then
  if [ -w /etc/passwd ]; then
    echo "${USER_NAME:-streama}:x:$(id -u):$(id -g):${USER_NAME:-streama} user:${HOME}:/sbin/nologin" >> /etc/passwd
  fi
fi

cp -n /staging/* ${HOME}

exec java -Dgrails.env=$ACTIVE_PROFILE -jar streama.war
