#!/bin/sh
/bin/cp /media/"$usb"/cache/installed /etc/files;
/bin/cp /etc/apk/world /etc/files;
/bin/cp -rp /home/* /etc/home/;
/sbin/lbu commit;
