#!/bin/sh
/sbin/rc-service udev stop
mp1="$(/sbin/losetup -a | /bin/sed 's/^.* * //')"
mp2="$(/bin/echo "${mp1}" | /bin/sed 's/\// /g' | /usr/bin/awk 'END {print $NF}')"
mp3="$(/bin/echo "${mp1}" | /bin/sed 's/\// /g' | /usr/bin/awk '{print $1,$2}' | sed 's/^/ /' | /bin/sed 's/ /\//g')"
/bin/cp "${mp1}" /
/bin/umount -d /dev/loop0
/bin/mount -o loop /"${mp2}" /.modloop
/bin/umount "${mp3}"
/sbin/rc-service udev start
