#!/bin/sh
usb="$(find /media/ -not -empty -type d -maxdepth 1 | grep -o '[^/]\+$')"
/sbin/setup-alpine; 
/usr/sbin/adduser admin; 
/bin/chmod -R 0700 /home/admin; 
/bin/mkdir /etc/home; 
/bin/chmod 0600 /etc/home;
/bin/echo "nameserver 46.182.19.48" > /etc/resolv.conf;
/bin/echo "nameserver 89.233.43.71" >> /etc/resolv.conf;
/bin/cat /media/"$usb"/files/sysctl.conf >> /etc/sysctl.conf;
/bin/chmod 0700 /etc/sysctl.conf;
/bin/mkdir /etc/files;
/bin/cp /media/"$usb"/files/firewall.nft /etc/files;
/bin/cp /media/"$usb"/files/noroot.sh /etc/files;
/bin/cp /media/"$usb"/files/startscript.sh /etc/files;
/bin/cp /media/"$usb"/files/log.sh /etc/files;
/bin/cp /media/"$usb"/512checksums.sha /etc/files;
/bin/chmod -R 0500 /etc/files;
/bin/cp -r /media/"$usb"/files/aa-profile /etc/files;
/bin/cp -r /media/"$usb"/files/abstractions /etc/files;
/bin/cp -r /media/"$usb"/files/local /etc/files;
/bin/echo -e "tmpfs /home tmpfs nosuid,nodev,noexec,mode=0755 0 0\ntmpfs /tmp tmpfs nosuid,nodev,noexec 0 0\ntmpfs /var/tmp tmpfs nosuid,nodev,noexec 0 0" >> /etc/fstab;
/bin/cp /media/"$usb"/files/boot.start /etc/local.d;
/bin/chmod 0500 /etc/local.d/boot.start;
/sbin/rc-update add local default;
/sbin/apk verify /media/"$usb"/serverapk/*sudo*;
/sbin/apk add --force-non-repository /media/"$usb"/serverapk/*sudo*;
/bin/echo -e "Defaults secure_path=\"/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin\"\nDefaults passwd_tries=1\nDefaults use_pty\nDefaults env_reset, timestamp_timeout=0\nadmin ALL=(ALL) ALL" | EDITOR="/usr/bin/tee -a" /usr/sbin/visudo;
/bin/echo -e "/dev/sda1 /media/sda1 auto noauto,nosuid,nodev,noexec,user 0 0\n/dev/sdb1 /media/sdb1 auto noauto,nosuid,nodev,noexec,user 0 0\n/dev/sdc1 /media/sdc1 auto noauto,nosuid,nodev,noexec,user 0 0" >> /etc/fstab;
/bin/echo -e "admin ALL=(ALL) NOPASSWD: /usr/sbin/openvpn, /bin/umount /dev/sda1, /bin/umount /dev/sdb1, /bin/umount /dev/sdc1, /sbin/poweroff, /etc/init.d/networking restart, /sbin/setup-interfaces" >> /etc/sudoers;
/bin/sed -i "1s/:::::/::::1:/g" /etc/shadow; 
/bin/sed -i "s/^/#/" /etc/securetty; 
/usr/bin/passwd -l root;
/bin/sed -i 's/umask 022/umask 077/g' /etc/profile;
/bin/echo "Run "exit", then login with the user admin and run "/usr/bin/sudo /bin/sh /media/"$usb"/server2.sh""
