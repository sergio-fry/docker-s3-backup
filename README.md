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

| Option               | Description                          | Default                                      |
|----------------------|--------------------------------------|----------------------------------------------|
| INCR_BACKUP_SCHEDULE | incremental backups schedule         | `0 0 \\* \\* \\*`                              |
| FULL_BACKUP_SCHEDULE | full backups schedule                | `15 0 \\*/7 \\* \\*`                          |
| MAX_FULL_BACKUPS     | How much full backups to store at S3 | 6                                            |
| TARGET_PATH          | S3 path to store backups             | my-backuped-files                            |
| CLEANUP_SCHEDULE     | duplicity cleanup schedule           | `0 3 1 \\* \\*`                                |
| DUMP_COMMAND         | Command to generate a dump           | pg_dumpall -h db -U postgres > $SRC/dump.sql |

