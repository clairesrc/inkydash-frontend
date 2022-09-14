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
    && addgroup pulse \
    && echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
    && echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
    && apk add --no-cache --purge -uU \
    curl icu-libs unzip zlib-dev musl \
    alsa-utils alsa-plugins-pulse \
    mesa-gl mesa-dri-swrast \
    pulseaudio udev \
    firefox-esr \
    libstdc++ libgcc dbus-x11 \
    && adduser alpine audio \
    && adduser alpine video \
    && adduser alpine pulse \
    && rm -rf /var/cache/apk/* /tmp/*
#
VOLUME /home/alpine/
#
USER alpine
WORKDIR /home/alpine/


ADD inkydash.py .
ADD inkydash.html .

CMD [ "python3", "inkydash.py"]
