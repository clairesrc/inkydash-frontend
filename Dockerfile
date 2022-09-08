FROM woahbase/alpine-rpigpio

ENV TZ "America/Chicago"
ENV INKYDASH_SERVER_LOCATION "localhost:8080"

RUN pip install --upgrade pip

RUN mkdir /inkydash
WORKDIR /inkydash

ADD requirements.txt .

RUN pip install -r requirements.txt

ADD inkydash.py .

CMD [ "python3", "inkydash.py"]
