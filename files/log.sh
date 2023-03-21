#!/bin/sh
while :
do
clear && clear
/usr/bin/sudo -u logcheck /usr/sbin/logcheck -o -t | /bin/grep -v "COMMAND=/usr/sbin/logcheck -o -t\|COMMAND=/bin/cat /var/log/audit/audit.log\|COMMAND=/sbin/aureport\|COMMAND=/bin/rc-status -a\|COMMAND=/sbin/auditctl -s"
sleep 33
clear && clear
/bin/echo "AUDIT LOG"
/usr/bin/sudo /bin/cat /var/log/audit/audit.log
/bin/echo ""
/usr/bin/sudo /sbin/aureport
sleep 33
clear && clear
/bin/echo "SERVICES AND RUNLEVELS"
/usr/bin/sudo /bin/rc-status -a
/bin/echo ""
/bin/echo "AUDIT STATUS"
/usr/bin/sudo /sbin/auditctl -s
sleep 15
clear && clear
/bin/ps -o pid,user,group,rss,stat,ppid,pgid,ruser,rgroup,etime,args
sleep 25
file=/var/log/messages
msize=3000000
size="$(/usr/bin/wc -c <"$file")"
if [ "$size" -ge "$msize" ]; then
/bin/sed -i -e "/COMMAND=\/usr\/sbin\/logcheck -o -t/d" -e "/COMMAND=\/bin\/cat \/var\/log\/audit\/audit.log/d" -e "/COMMAND=\/sbin\/aureport/d" -e "/COMMAND=\/bin\/rc-status -a/d" -e "/COMMAND=\/sbin\/auditctl -s/d" /var/log/messages 
else
/bin/echo ""
fi
done