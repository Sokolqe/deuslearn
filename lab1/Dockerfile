ARG IMAGE=alpine:3.21.3
FROM $IMAGE

#Add variables to make unprivileged user in future
ARG UID=101
ARG GID=101

#Creating unprivileged system user and forwarding logs to docker output
RUN set -x \
    && mkdir -p /var/cache/nginx \
    && addgroup -g $GID -S nginx \
    && adduser -S -D -H -u $UID -h /var/cache/nginx -s /sbin/nologin -G nginx -g nginx nginx \
    && apk add --no-cache nginx \
    && ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

#Implementing changes to run nginx as unprivileged user
RUN set -x \
    && sed -i '/user nginx;/d' /etc/nginx/nginx.conf \
    && sed -i 's,/var/run/nginx.pid,/tmp/nginx.pid,' /etc/nginx/nginx.conf \
    && sed -i "/^http {/a \    proxy_temp_path /tmp/proxy_temp;\n    client_body_temp_path /tmp/client_temp;\n    fastcgi_temp_path /tmp/fastcgi_temp;\n    uwsgi_temp_path /tmp/uwsgi_temp;\n    scgi_temp_path /tmp/scgi_temp;\n" /etc/nginx/nginx.conf \
    && mkdir /etc/nginx/sites-enabled \
    && chown -R $UID:$GID /var/cache/nginx \
    && chown -R $UID:$GID /etc/nginx

#Switching to a user, who will run nginx inside a container
USER $UID

EXPOSE "8080/tcp"

#Bringing configuration file and static content from host machine inside container
VOLUME "/etc/nginx/http.d" "/etc/nginx/sites-enabled"

#Run command without spawning worker processes
CMD ["nginx", "-g", "daemon off;"]

