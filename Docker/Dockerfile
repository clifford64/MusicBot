FROM eclipse-temurin:25-jre-noble

ARG DEBIAN_FRONTEND=noninteractive

RUN set -eux; \
    apt-get update; \
    # only the tools we need to get the key & install chrome
    apt-get install -y --no-install-recommends wget gnupg ca-certificates; \
    # fetch key & add repo
    wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add -; \
    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list; \
    # install chrome itself
    apt-get update; \
    apt-get install -y --no-install-recommends google-chrome-stable; \
    # purge the helper packages and clean apt cache
    apt-get purge -y --auto-remove wget gnupg ca-certificates; \
    rm -rf /var/lib/apt/lists/*

ENV JMB_VERSION 0.4.3

#No downloadable example config since 0.2.10
RUN mkdir -p /jmb/config
ADD JMusicBot-0.4.3.jar /jmb/JMusicBot.jar
#ADD https://github.com/Amavect/MusicBot/releases/download/0.2.9/config.txt /jmb/config/config.txt

COPY ./docker-entrypoint.sh /jmb

RUN chmod +x /jmb/docker-entrypoint.sh
RUN chmod 770 /jmb/JMusicBot.jar

VOLUME /jmb/config

RUN useradd -Ms /bin/bash -u 3002 -U musicbot

RUN chgrp -R musicbot /jmb

USER musicbot

ENTRYPOINT ["/jmb/docker-entrypoint.sh"]