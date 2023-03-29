FROM perl:latest

EXPOSE 80
WORKDIR /usr/src/app
COPY . /usr/src/app

RUN curl -L http://cpanmin.us | perl - App::cpanminus
RUN cpanm  --installdeps .

CMD ["perl", "app.pl", "daemon", "-m", "production", "-l", "http://*:80"]