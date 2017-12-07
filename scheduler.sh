#!/bin/bash

echo "$INCR_BACKUP_SCHEDULE /usr/local/bin/backup.sh"
echo "$FULL_BACKUP_SCHEDULE /usr/local/bin/backup.sh full"

#start-cron "$INCR_BACKUP_SCHEDULE /usr/local/bin/backup.sh >> /var/log/cron.log 2>&1"

start-cron "$INCR_BACKUP_SCHEDULE echo 'Incremental backup...' >> /var/log/cron.log 2>&1" \
  "$FULL_BACKUP_SCHEDULE echo 'Full backup...' >> /var/log/cron.log 2>&1"
