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

# Run incremental backup each night
ENV INCR_BACKUP_SCHEDULE="0 0 \\* \\* \\*"

# Run full backup each week
ENV FULL_BACKUP_SCHEDULE="15 0 */7 \\* \\*"

CMD ["scheduler.sh"]
