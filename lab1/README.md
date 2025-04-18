# deuslearn
Homework repo

## Lab1
- You need to get whole directory "lab1" to your environment and use it as a build context

- Directory "nginx" contains two subdirectories:
    1. http.d - which you need to mount as VOLUME to a ```/etc/nginx/http.d``` inside a container.
        - There are default.conf which allows you to get index.html by following comand from a host machine
          ```bash
          curl http://localhost:8080
          ```
        - You can place there your own configurations, as much, as you need. It will be inside ```http {}``` directive
    2. sites-enabled - which you need to mount as VOLUME to a ```/etc/nginx/sites-enabled``` inside a container
        - This allows you put your static content inside container from host machine

- There are "Dockerfile" in "lab1" which allows you to build image for container
    1. You need to replace group on configs and index.html to a GID, who will run container as unprivileged user (101 by default)
        - ```bash
          sudo chown -R :101 ./nginx
          ```
    2. Then run build:
        - ```bash
          docker build -t *your_tag* .
          ```
    3. And run container:
        - ```bash
          docker run -d -p 8080:8080 -v "./nginx/http.d:/etc/nginx/http.d" -v "./nginx/sites-enabled:/etc/nginx/sites-enabled" *your_tag*
          ```
- There are "compose.yaml" which allows you to run container by compose:
    1. You need to replace group on configs and index.html to a GID, who will run container as unprivileged user (101 by default)
        - ```bash
          sudo chown -R :101 ./nginx
          ```
    2. And run a compose:
        - ```bash
          docker compose up -d
          ```
