FROM debian:jessie

RUN apt-get update
RUN apt-get install -y curl

RUN curl -o /usr/local/bin/mantra -L https://github.com/pugnascotia/mantra/releases/download/0.0.1/mantra && \
    chmod +x /usr/local/bin/mantra

RUN apt-get install -y postgresql-client-9.4
RUN apt-get install -y duplicity

VOLUME /dumps/
VOLUME /backups

COPY backup.sh /usr/local/bin/
COPY scheduler.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/*

ENV TASK="backup.sh"
ENV SCHEDULE="*/10 * * * * *"

CMD ["scheduler.sh"]
