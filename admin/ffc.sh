#!/bin/sh
/usr/bin/firefox &
last_pid="$!"
sleep 1
/bin/kill -KILL "$last_pid"
p1="$(find /home/admin/.mozilla/firefox/ -name "*.default-default")"
/bin/cp /home/admin/user.js "${p1}";

