#!/bin/sh
/bin/more /proc/sys/kernel/random/poolsize;
</dev/urandom /usr/bin/tr -dc 'A-Za-z0-9!"#$%&'\''()*+,-./:;<=>?@[\]^_`{|}~' | /usr/bin/head -c 472 > passwdneu
