FROM python:alpine

ENV TZ "America/Chicago"
ENV INKYDASH_SERVER_LOCATION "localhost:5000"

ARG PUID=1001
ARG PGID=1001

RUN set -xe \
    && apk add --no-cache -Uu --virtual .build-dependencies python3-dev libffi-dev openssl-dev build-base musl \
    && pip3 install --no-cache --upgrade pyserial \
    && apk del --purge .build-dependencies \
    && apk add --no-cache --purge curl ca-certificates libjpeg-turbo-dev zlib-dev wiringpi python3-dev linux-headers font-noto freetype-dev \
    && rm -rf /var/cache/apk/* /tmp/*

RUN mkdir /inkydash
WORKDIR /inkydash

ADD requirements.txt .

RUN pip install -r requirements.txt --only-binary=:all: --no-binary=Pillow

ADD inkydash.py .

CMD [ "python3", "inkydash.py"]
