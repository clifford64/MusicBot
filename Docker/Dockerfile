FROM eclipse-temurin:23-jre-noble

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
