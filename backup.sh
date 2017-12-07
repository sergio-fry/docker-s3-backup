#!/bin/sh

echo "Backup started"
pg_dumpall -h db -U postgres > /dumps/dump.sql
duplicity --no-encryption /dumps file:///backups/
duplicity --no-encryption collection-status file:///backups/
