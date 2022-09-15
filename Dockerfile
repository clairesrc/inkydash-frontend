FROM clairesrc/alpine-inky

ENV TZ "America/Chicago"
ENV INKYDASH_SERVER_LOCATION "inkydash:5000"
ENV INKYDASH_CLIENT_FILENAME "/inkydash.html"

ADD requirements.txt .
ADD inkydash.py .
ADD screenshotter.py .
ADD inkydash.html .

RUN pip install -r requirements.txt

CMD [ "python", "./inkydash.py"]
