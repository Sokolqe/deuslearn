ARG IMAGE=python:3.11-alpine3.21
FROM $IMAGE

#Add variables to make unprivileged user in future
ARG UID=101
ARG GID=101
ARG USERNAME=djangogirls
ARG GROUPNAME=djangogirls

#Add environment variables for our app
ARG user
ARG email
ARG password
ARG file
ENV user=admin
ENV email=admin@example.com
ENV password=pass
ENV file=/app/db/db.sqlite3

#Add enviroment variables for postgres db connection
ARG DB_NAME
ARG DB_USER
ARG DB_PASSWORD
ARG DB_HOST
ARG DB_PORT
ENV DB_NAME=django
ENV DB_USER=django
ENV DB_PASSWORD=django
ENV DB_HOST=db
ENV DB_PORT=5432

WORKDIR /app

COPY --chown=$UID:$GID requirements.txt /app/

#Creating unprivileged system user and installing necessary requirements
RUN set -x \
    && addgroup -g $GID -S $GROUPNAME \
    && adduser -S -D -H -u $UID -h /app -s /sbin/nologin -G $GROUPNAME -g $GROUPNAME $USERNAME \
    && python -m pip install -r requirements.txt

#Bringing source code
COPY --chown=$UID:$GID . /app/

EXPOSE "8000/tcp"

#Database directory
VOLUME "/app/db" 

USER $UID

#Run command
CMD ["sh", "init.sh"]

