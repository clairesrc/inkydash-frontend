FROM woahbase/alpine-rpigpio:aarch64

ENV TZ "America/Chicago"
ENV INKYDASH_SERVER_LOCATION "localhost:8080"

RUN apk add libjpeg-turbo-dev zlib-dev python3-dev build-base linux-headers
RUN pip install --upgrade pip

RUN mkdir /inkydash
WORKDIR /inkydash

ADD requirements.txt .

RUN pip install -r requirements.txt

ADD inkydash.py .

CMD [ "python3", "inkydash.py"]
