FROM alpine:3.7

ENV PYTHONUNBUFFERED 1

EXPOSE 4000-5000

RUN apk add --no-cache uwsgi-python3 && pip3 install bs4

CMD [ "uwsgi", "/var/uwsgi/uwsgi.ini" ]

# Entry point to use instead of "CMD" for manual debugging
# ENTRYPOINT while true; do sleep 1000; done