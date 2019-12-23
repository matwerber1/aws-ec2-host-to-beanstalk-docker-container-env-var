FROM python:2.7

ADD application.py /tmp/application.py
COPY commands.sh /tmp/commands.sh
RUN ["chmod", "+x", "/tmp/commands.sh"]

EXPOSE 8000
ENTRYPOINT ["/tmp/commands.sh"]