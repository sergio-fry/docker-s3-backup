#!/bin/sh

echo "$SCHEDULE root /usr/local/bin/backup.sh"

echo "* * * * * root sh -e /usr/local/bin/backup.sh > /proc/2/fd/1 2>/proc/1/fd/2" > /etc/cron.d/my-crontab
chmod 0644 /etc/cron.d/my-crontab

cron -f
