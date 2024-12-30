#!/usr/bin/bash

if [[ -z "$PUID" ]]; then
    echo "PUID envar must be set"
    exit
fi

if [[ -z "$PGID" ]]; then
    echo "PGID envar must be set"
    exit
fi

PUID=${PUID:-911}
PGID=${PGID:-911}

groupmod -o -g "$PGID" abc
usermod -o -u "$PUID" abc

echo '
-------------------------------------
GID/UID
-------------------------------------'
echo "
User uid:    $(id -u abc)
User gid:    $(id -g abc)
-------------------------------------
"

# take ownership of our working directories and files
chown abc:abc /snapserver.conf

cat etc/snapserver.conf

# run the actual script with proper permissions
exec su abc -s snapserver -c /snapserver.conf
