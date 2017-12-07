FROM renskiy/cron:debian

RUN apt-get update && \
  apt-get install -y postgresql-client-9.4 duplicity python-pip

RUN pip install boto

VOLUME /dumps/
VOLUME /root/.cache/duplicity/

COPY backup.sh /usr/local/bin/
COPY scheduler.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/*

ENV TARGET_PATH=my-backuped-files

# Run incremental backup each night at 00:00
ENV INCR_BACKUP_SCHEDULE="0 0 \\* \\* \\*"

# Run full backup each week at 00:15
ENV FULL_BACKUP_SCHEDULE="15 0 \\*/7 \\* \\*"
ENV MAX_FULL_BACKUPS=6

# Run cleanup each 1st day at 03:00
ENV CLEANUP_SCHEDULE="0 3 1 \\* \\*"

CMD ["scheduler.sh"]
