#!/bin/sh
usb="$(find /media/ -not -empty -type d -maxdepth 1 | grep -o '[^/]\+$')"
/sbin/apk verify /media/"$usb"/serverapk/*.apk;
/sbin/apk add --force-non-repository /media/"$usb"/serverapk/*.apk;
#/bin/mount -o rw,remount /media/"$usb";
#/bin/sed -i '5 s/$/ vsyscall=none mce=0 slab_nomerge init_on_free=1 mds=full,nosmt page_alloc.shuffle=1 extra_latent_entropy module.sig_enforce=1 randomize_kstack_offset=on apparmor=1 lsm=landlock,lockdown,yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo/' /media/"$usb"/boot/extlinux/extlinux.conf;
#/bin/sed -i '4 s/$/ vsyscall=none mce=0 slab_nomerge init_on_free=1 mds=full,nosmt page_alloc.shuffle=1 extra_latent_entropy module.sig_enforce=1 randomize_kstack_offset=on apparmor=1 lsm=landlock,lockdown,yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo/' /media/"$usb"/boot/grub/grub.cfg;
#/bin/rm /media/"$usb"/boot/System.map*;
#/bin/mount -o ro,remount /media/"$usb";
/sbin/rc-update add apparmor boot;
/bin/chmod 0400 /etc/shadow;
/bin/chmod -R 0700 /etc/init.d;
/bin/chmod 0700 /etc/inittab;
/bin/cp -r /media/"$usb"/admin/* /home/admin;
/bin/chown admin:admin /home/admin/inet.sh;
/bin/chown admin:admin /home/admin/genpasswd.sh;
/bin/chown admin:admin /home/admin/ffc.sh;
/bin/chown admin:admin /home/admin/user.js;
/bin/sed -i  "s/^/#/" /etc/logcheck/logcheck.logfiles;
/bin/echo "/var/log/messages" >> /etc/logcheck/logcheck.logfiles;
/bin/chmod 0640 /etc/logcheck/logcheck.logfiles;
/bin/chown logcheck:root /etc/logcheck/logcheck.logfiles;
/bin/sed -i "s/.*max_log_file =.*/max_log_file = 500/" /etc/audit/auditd.conf;
/bin/sed -i "s/.*max_log_file_action =.*/max_log_file_action = KEEP_LOGS/" /etc/audit/auditd.conf;
/bin/sed -i "s/.*space_left_action =.*/space_left_action = SYSLOG/" /etc/audit/auditd.conf;
/bin/sed -i "s/.*admin_space_left =.*/admin_space_left = 50/" /etc/audit/auditd.conf;
/bin/sed -i "s/.*admin_space_left_action =.*/admin_space_left_action = SUSPEND/" /etc/audit/auditd.conf;
/bin/sed -i "s/.*disk_error_action =.*/disk_error_action = SYSLOG/" /etc/audit/auditd.conf;
/bin/chmod 0640 /etc/audit/auditd.conf;
/bin/chown root:root /etc/audit/auditd.conf;
/bin/sed -i "s/.*USE_AUGENRULES.*/USE_AUGENRULES="yes"/" /etc/sysconfig/auditd;
/bin/chmod 0640 /etc/sysconfig/auditd;
/bin/chown root:root /etc/sysconfig/auditd;
/bin/mkdir /etc/audit/rules.d;
/bin/chown root:root /etc/audit/rules.d;
/bin/chmod 0750 /etc/audit/rules.d;
/bin/cp /media/"$usb"/files/audit.rule /etc/audit/rules.d;
/bin/chmod 0500 /etc/audit/rules.d/audit.rule;
/bin/chown root:root /etc/audit/rules.d/audit.rule;
/bin/cp /media/"$usb"/historyserver/ash_history /home/admin;
/bin/mv /home/admin/ash_history /home/admin/.ash_history
/bin/chown admin:admin /home/admin/.ash_history;
/bin/chmod 0600 /home/admin/.ash_history
/bin/cp /media/"$usb"/cache/installed /etc/files;
/bin/cp /etc/apk/world /etc/files;
/bin/cp -rp /home/* /etc/home/;
/sbin/rc-update add klogd default;
/sbin/rc-update add nftables default;
/sbin/rc-update add auditd default;
/sbin/lbu commit;
/bin/echo "Shut down pc with the command "sudo poweroff" and copy localhost.apkovl.tar.gz in a other folder. Then start again the pc with Alpine Linux and run "/usr/bin/sudo /bin/sh /media/"$usb"/sway.sh" if you need Sway"
