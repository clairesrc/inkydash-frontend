FROM clairesrc/alpine-inky:dev

ENV TZ "America/Chicago"
ENV INKYDASH_SERVER_LOCATION "inkydash:5000"

ARG PUID=1001
ARG PGID=1001

RUN set -xe \
    && addgroup -g ${PGID} -S alpine \
    && adduser -u ${PUID} -G alpine -h /home/alpine -D alpine \
    && apk add --no-cache --purge -uU \
    mesa-gl mesa-dri-swrast dbus-x11 libpciaccess libpciaccess-dev glib glib-dev \
    firefox-esr \
    && adduser alpine audio \
    && adduser alpine video \
    && rm -rf /var/cache/apk/* /tmp/*

RUN chmod 4755 /usr/bin/su

VOLUME /home/alpine/
#
USER alpine
WORKDIR /home/alpine/



ADD requirements.txt .
ADD inkydash.sh .
ADD inkydash.py .
ADD inkydash.html .

RUN pip install -r requirements.txt

CMD [ "./inkydash.sh"]
