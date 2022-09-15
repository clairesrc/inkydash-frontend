FROM clairesrc/alpine-inky

ENV TZ "America/Chicago"
ENV INKYDASH_SERVER_LOCATION "inkydash:5000"

ADD requirements.txt .
ADD inkydash.sh .
ADD inkydash.py .
ADD inkydash.html .

RUN pip install -r requirements.txt

CMD [ "./inkydash.sh"]
