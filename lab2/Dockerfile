ARG IMAGE=python:3.11-alpine3.21
FROM $IMAGE

#Add variables to make unprivileged user in future
ARG UID=101
ARG GID=101
ARG USERNAME=djangogirls
ARG GROUPNAME=djangogirls
ARG user
ARG email
ARG password

ENV user=admin
ENV email=admin@example.com
ENV password=pass

WORKDIR /app

COPY --chown=$UID:$GID requirements.txt /app/

#Creating unprivileged system user and installing necessary requirements
RUN set -x \
    && addgroup -g $GID -S djangogirls \
    && adduser -S -D -H -u $UID -h /app -s /sbin/nologin -G djangogirls -g djangogirls djangogirls \
    && python -m pip install -r requirements.txt

COPY --chown=$UID:$GID . /app/

EXPOSE "8000/tcp"

#Bringing configuration file and static content from host machine inside container
VOLUME "/app/db" 

#Run command without spawning worker processes
ENTRYPOINT ["/bin/ash"]
CMD ["init.sh"]

