#!/bin/sh

echo `date`
echo "Creating a database dump... ---------------------------------"
pg_dumpall -h db -U postgres > /dumps/dump.sql
ls -l /dumps/dump.sql

echo "Cleaning up redundant files... ------------------------------"
rm -rf /root/.cache/duplicity/*
#duplicity --allow-source-mismatch --no-encryption --s3-use-new-style cleanup --force s3+http://$S3_BUCKET/$TARGET_PATH

# --tempdir
# --s3-use-multiprocessing
echo "Uploading to S3... ------------------------------------------"
duplicity --allow-source-mismatch --no-encryption --s3-use-new-style /dumps s3+http://$S3_BUCKET/$TARGET_PATH

echo "Retreiving collection info... -------------------------------"
duplicity --allow-source-mismatch --no-encryption --s3-use-new-style collection-status s3+http://$S3_BUCKET/$TARGET_PATH
duplicity --allow-source-mismatch --no-encryption --s3-use-new-style list-current-files s3+http://$S3_BUCKET/$TARGET_PATH

exit 0
