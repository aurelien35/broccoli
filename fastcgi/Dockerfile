FROM python:alpine3.6 

ENV PYTHONUNBUFFERED 1

EXPOSE 4016

RUN apk add --update fcgiwrap && \
    apk add --update spawn-fcgi && \
    rm -rf /var/cache/apk/* && \
	pip install bs4

ENTRYPOINT while true; do sleep 1000; done