FROM debian:jessie

RUN apt-get update && \
  apt-get install -y curl postgresql-client-9.4 duplicity python-pip cron

RUN curl -o /usr/local/bin/mantra -L https://github.com/pugnascotia/mantra/releases/download/0.0.1/mantra && \
    chmod +x /usr/local/bin/mantra

RUN pip install boto


VOLUME /dumps/
VOLUME /root/.cache/duplicity/

COPY backup.sh /usr/local/bin/
COPY scheduler.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/*

ENV TASK="backup.sh"
ENV SCHEDULE="0 * * * * *"
ENV TARGET_PATH=my-backuped-files

CMD ["scheduler.sh"]
