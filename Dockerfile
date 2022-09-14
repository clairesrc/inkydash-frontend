FROM clairesrc/alpine-inky
RUN mkdir /inkydash
WORKDIR /inkydash

ADD requirements.txt .

RUN pip install -r requirements.txt

ADD inkydash.py .
ADD inkydash.html .

CMD [ "python3", "inkydash.py"]
