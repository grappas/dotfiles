#!/bin/sh
#
USER="$1"
HOST="$2"
REMOTE_PATH="$3"
mkdir -p ~/temp/mountpoints/"$USER@$HOST:$(echo $REMOTE_PATH | sed 's/\//-/g')"
sshfs "$USER@$HOST:$REMOTE_PATH" ~/temp/mountpoints/"$USER@$HOST:$(echo $REMOTE_PATH | sed 's/\//-/g')"
