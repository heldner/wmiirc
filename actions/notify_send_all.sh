#!/bin/sh

PATH=/usr/bin
MESSAGE="$*"

notify_all_users () {
    all_users=$(who | cut -d' ' -f 1 | uniq)
    for user in $all_users; do
        export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u $user)/bus
        notify-send 'NOTIFY:' "$MESSAGE"
    done
}

listen_power_changes () {
    upower --monitor-detail | while read line; do
        echo $line
    done
}

notify_all_users
