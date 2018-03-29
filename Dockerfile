FROM        ubuntu:17.10

RUN         apt-get -y update
RUN         apt-get -y dist-upgrade
RUN         apt-get -y install supervisor
RUN         apt-get -y install cron
RUN         apt-get -y install vim

COPY        . /cron
WORKDIR     /var/spool/cron/crontabs

#RUN         crontab
RUN         touch /var/spool/cron/crontabs/root && chmod 600 root &&\
            echo "* * * * * echo Hello >> /var/log/cron.log" >> root &&\
            touch /var/log/cron.log &&\
            cp /cron/supervisord.conf /etc/supervisor/conf.d/

#CMD         cron -f
CMD         supervisord -n
# -n옵션은 front에서 service같이 실행하기 위해서 넣는 옵션이다.


# docker run 뒤에 /bin/bash같은 명령어가 붙으면 CMD가 무시된다.

# docker exec 9be5 tail -f /var/log/cron.log 명령어로 확