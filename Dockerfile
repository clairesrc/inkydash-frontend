FROM clairesrc/alpine-inky
RUN mkdir /inkydash
WORKDIR /inkydash

ARG PUID=1001
ARG PGID=1001

ADD requirements.txt .

RUN pip install -r requirements.txt


RUN set -xe \
    && addgroup -g ${PGID} -S alpine \
    && adduser -u ${PUID} -G alpine -h /home/alpine -D alpine \
    && echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
    && echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
    && apk add --no-cache --purge -uU \
    mesa-gl mesa-dri-swrast dbus-x11 \
    firefox-esr \
    && adduser alpine audio \
    && adduser alpine video \
    && rm -rf /var/cache/apk/* /tmp/*
#
VOLUME /home/alpine/
#
USER alpine
WORKDIR /home/alpine/


ADD inkydash.py .
ADD inkydash.html .

CMD [ "python3", "inkydash.py"]
