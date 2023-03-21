#!/bin/sh
usb="$(find /media/ -not -empty -type d -maxdepth 1 | grep -o '[^/]\+$')"
/sbin/setup-alpine
/bin/sed -i 's/ //g' /etc/apk/repositories;
/bin/sed -i 's/#//g' /etc/apk/repositories;
# /bin/sed -i 's/http/https/g' /etc/apk/repositories;
/bin/sed -i '/edge/ s/^/#/' /etc/apk/repositories;
/sbin/apk update;
/sbin/apk update;
/bin/sh /media/"$usb"/server-apk.sh;
/etc/init.d/networking stop;
/bin/mount -o rw,remount /media/"$usb";
/bin/mkdir /media/"$usb"/serverapk;
/bin/cp /media/"$usb"/cache/* /media/"$usb"/serverapk;
/bin/mount -o ro,remount /media/"$usb";
/etc/init.d/networking restart;
/etc/init.d/networking restart;
/bin/sh /media/"$usb"/sway-apk.sh;
/etc/init.d/networking stop;
/bin/mount -o rw,remount /media/"$usb";
/bin/mkdir /media/"$usb"/swayapk;
/bin/cp /media/"$usb"/cache/* /media/"$usb"/swayapk;
/bin/echo "Disconnect the PC from the Internet, turn off the PC and continue with step 4."
