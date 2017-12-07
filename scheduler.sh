#!/bin/bash

echo "$INCR_BACKUP_SCHEDULE /usr/local/bin/backup.sh"
echo "$FULL_BACKUP_SCHEDULE /usr/local/bin/backup.sh full"
echo "$CLEANUP_SCHEDULE /usr/local/bin/backup.sh cleanup"

#start-cron "$INCR_BACKUP_SCHEDULE /usr/local/bin/backup.sh >> /var/log/cron.log 2>&1"

start-cron "$INCR_BACKUP_SCHEDULE /usr/local/bin/backup.sh >> /var/log/cron.log 2>&1" \
  "$FULL_BACKUP_SCHEDULE /usr/local/bin/backup.sh full >> /var/log/cron.log 2>&1" \
  "$CLEANUP_SCHEDULE /usr/local/bin/backup.sh cleanup >> /var/log/cron.log 2>&1"
