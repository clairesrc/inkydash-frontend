FROM clairesrc/alpine-inky

ENV TZ "America/Chicago"
ENV INKYDASH_SERVER_LOCATION "inkydash:5000"
ENV INKYDASH_CLIENT_FILENAME "/inkydash.html"
RUN apk update && apk add --no-cache bash \
    alsa-lib \
    at-spi2-atk \
    atk \
    cairo \
    cups-libs \
    dbus-libs \
    eudev-libs \
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
    chromium-chromedriver

ADD requirements.txt .
ADD inkydash.py .
ADD screenshotter.py .
ADD inkydash.html .

RUN pip install -r requirements.txt

CMD [ "python", "./inkydash.py"]
