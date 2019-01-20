FROM openjdk:8-jre
EXPOSE 8080

WORKDIR /app

ENV USER_UID=1001 \
    USER_NAME=streama \
    HOME=/opt/streama \
    ACTIVE_PROFILE=docker

RUN mkdir -p ${HOME} /data /staging \
 && chown -R ${USER_UID}:0 ${HOME} \
 && chown -R ${USER_UID}:0 /staging \
 && chown -R ${USER_UID}:0 /data \
 && chmod -R ug+rwx ${HOME} /data /staging \
 && chmod g+rw /etc/passwd

COPY bin/entrypoint.sh /bin/entrypoint.sh
RUN chmod +x /bin/entrypoint.sh

RUN wget https://raw.githubusercontent.com/streamaserver/streama/master/grails-app/conf/application.yml -P /staging -O application.yml
RUN wget $(wget -qO- 'https://api.github.com/repos/streamaserver/streama/releases/latest' | grep browser_download_url | cut -d '"' -f 4) -P /staging -O streama.war

USER ${USER_UID}

ENTRYPOINT ["sh", "/bin/entrypoint.sh"]
