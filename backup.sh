#!/bin/sh

export DST="s3+http://$S3_BUCKET/$TARGET_PATH"
export SRC=/dumps
export OPTIONS="--allow-source-mismatch --no-encryption --s3-use-new-style"

echo `date`
echo "Creating a database dump... ---------------------------------"
/usr/local/bin/dump.sh
ls -l $SRC/

echo "Cleaning up redundant files... ------------------------------"
rm -rf /root/.cache/duplicity/*


# --tempdir
# --s3-use-multiprocessing

if [ "$1" = "cleanup" ]; then
  echo "Cleaning up... ------------------------------------------"
  duplicity cleanup --force $OPTIONS $DST
  duplicity remove-all-but-n-full --force $MAX_FULL_BACKUPS $OPTIONS $DST

else
  echo "Uploading to S3... ------------------------------------------"
  if [ "$1" = "full" ]; then
    echo "Full backup"
    duplicity full $OPTIONS $SRC $DST
  else
    echo "Incremental backup"
    duplicity incremental $OPTIONS $SRC $DST
  fi
fi

echo "Retreiving collection info... -------------------------------"
duplicity $OPTIONS collection-status $DST
duplicity $OPTIONS list-current-files $DST

exit 0
