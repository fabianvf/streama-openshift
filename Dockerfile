FROM openjdk:8-jre
VOLUME /data
EXPOSE 8080

WORKDIR /app
COPY bin/entrypoint.sh /bin/entrypoint.sh
RUN chmod +x /bin/entrypoint.sh

ENV USER_UID=1001 \
    USER_NAME=streama \
    HOME=/opt/streama \
    ACTIVE_PROFILE=docker

RUN wget https://raw.githubusercontent.com/streamaserver/streama/master/grails-app/conf/application.yml -P ${HOME} -O application.yml
RUN wget $(wget -qO- 'https://api.github.com/repos/streamaserver/streama/releases/latest' | grep browser_download_url | cut -d '"' -f 4) -P ${HOME} -O streama.war

RUN chown -R ${USER_UID}:0 ${HOME} \
 && chmod -R ug+rwx ${HOME} \
 && chmod g+rw /etc/passwd


ENTRYPOINT ["sh", "entrypoint.sh"]
