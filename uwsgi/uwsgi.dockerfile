FROM alpine:3.7

ENV PYTHONUNBUFFERED 1

EXPOSE 4016

RUN apk add --no-cache uwsgi-python3 && pip3 install bs4

CMD [ "uwsgi", "/var/uwsgi/uwsgi.ini" ]

#ENTRYPOINT while true; do sleep 1000; done