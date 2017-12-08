# Docker S3 Backup

Schedule your backups easily. PostgreSQL, MySQL any other files from volumes.

## PostgreSQL Backups example

```
backup:
  image: udalov/docker-s3-backup

  links:
    - pg:pg

  environment:
    DUMP_COMMAND: "pg_dumpall -U postgres -h pg"
    AWS_ACCESS_KEY_ID=AKIA...
    AWS_SECRET_ACCESS_KEY=ILR7E.....
    S3_BUCKET=my-bucket

pg:
  image: postgres:9.4

```

## Configuration

INCR_BACKUP_SCHEDULE
FULL_BACKUP_SCHEDULE
MAX_FULL_BACKUPS
TARGET_PATH
CLEANUP_SCHEDULE
DUMP_COMMAND
