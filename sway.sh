#!/bin/sh
usb="$(find /media/ -not -empty -type d -maxdepth 1 | grep -o '[^/]\+$')"
/sbin/apk verify /media/"$usb"/swayapk/*.apk;
/sbin/apk add --force-non-repository /media/"$usb"/swayapk/*.apk;
/sbin/setup-devd udev;
/bin/mkdir /home/admin/.config;
/bin/chmod 0755 /home/admin/.config;
/bin/chown admin:admin /home/admin/.config;
/bin/cp -r /media/"$usb"/files/yambar /home/admin/.config;
/bin/chmod 0755 /home/admin/.config/yambar;
/bin/chown admin:admin /home/admin/.config/yambar;
/bin/chown admin:admin /home/admin/.config/yambar/config.yml;
/bin/chmod 0644 /home/admin/.config/yambar/config.yml;
/usr/sbin/addgroup admin input;
/usr/sbin/addgroup admin video;
/usr/sbin/addgroup admin audio;
/usr/sbin/addgroup root audio;
/sbin/rc-update add alsa;
/sbin/rc-update add seatd;
/bin/touch /tmp/difflog;
/usr/bin/diff /media/"$usb"/files/config /etc/sway/config >> /tmp/difflog;
/bin/cp /media/"$usb"/files/xdg_runtime_dir.sh /etc/profile.d;
/bin/chmod 0755 /etc/profile.d/xdg_runtime_dir.sh;
/bin/cp /media/"$usb"/files/config /etc/sway;
/bin/chmod 0644 /etc/sway/config;
/bin/sed -i '23i export MOZ_ENABLE_WAYLAND=1' /etc/profile;
/bin/sed -i '23i export WLR_NO_HARDWARE_CURSORS=1' /etc/profile;
/bin/cp /media/"$usb"/historyserver/ash_history /home/admin;
/bin/mv /home/admin/ash_history /home/admin/.ash_history
/bin/chown admin:admin /home/admin/.ash_history;
/bin/chmod 0600 /home/admin/.ash_history;
/bin/cp /media/"$usb"/cache/installed /etc/files;
/bin/cp /etc/apk/world /etc/files
/bin/cp -rp /home/* /etc/home/;
/sbin/lbu commit;
/bin/echo "Shut down pc and copy localhost.apkovl.tar.gz in a other folder. Then you can start Alpine Linux and use Sway with the command "sway""
