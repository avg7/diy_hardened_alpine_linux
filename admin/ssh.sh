#!/bin/sh
/usr/bin/sudo /sbin/apk add openssh-client haveged;
/usr/bin/sudo /bin/chmod +s /bin/su;
/usr/bin/sudo /usr/sbin/nft -f ssh_firewall.nft;
/bin/echo "Datum und Uhrzeit kontrollieren, dann folgenden Befehl eingeben: "sudo sh end.sh";
