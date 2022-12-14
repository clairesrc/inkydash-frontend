FROM clairesrc/alpine-inky

ENV TZ "America/Chicago"
ENV INKYDASH_API_URL "http://inkydash:5000/data"
ENV INKYDASH_THEME "default"
ENV DEBUG "false"
RUN apk update && apk add --no-cache bash \
    alsa-lib \
    at-spi2-atk \
    atk \
    cairo \
    cups-libs \
    dbus-libs \
    eudev-libs \
    py3-pip \
    expat \
    flac \
    gdk-pixbuf \
    glib \
    libgcc \
    libjpeg-turbo \
    libpng \
    libwebp \
    libx11 \
    libxcomposite \
    libxdamage \
    libxext \
    libxfixes \
    tzdata \
    libexif \
    udev \
    xvfb \
    zlib-dev \
    chromium \
    chromium-chromedriver \
    git

RUN mkdir themes

ADD requirements.txt .
ADD inkydash.py .
ADD screenshotter.py .
ADD inkydash.html .
ADD inkydash.js .
ADD themes/* themes

RUN /usr/bin/pip3 install -r requirements.txt

CMD [ "python", "./inkydash.py"]
