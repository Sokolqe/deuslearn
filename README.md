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
          sudo chown -R 101:101 ${PATH_TO_YOUR_DIRECTORY}/nginx
          ```
    2. Then run build:
        - ```bash
          docker build -t *your_tag* .
          ```
    3. And run container:
        - ```bash
          docker run -d -p 8080:8080 -v "${PATH_TO_YOUR_DIRECTORY}/nginx/http.d:/etc/nginx/http.d" -v "${PATH_TO_YOUR_DIRECTORY}/nginx/sites-enabled:/etc/nginx/sites-enabled" *your_tag*
          ```
- There are "compose.yaml" which allows you to run container by compose:
    1. You need to replace group on configs and index.html to a GID, who will run container as unprivileged user (101 by default)
        - ```bash
          sudo chown -R 101:101 ${PATH_TO_YOUR_DIRECTORY}/nginx
          ```
    2. Change volumes directive for ```${PATH_TO_YOUR_DIRECTORY}/nginx:/etc/nginx/*``` and run a compose:
        - ```bash
          docker compose up -d
          ```


## Lab2
- You need to get whole directory "lab2" to your environment and use it as a build context
 
- There are "Dockerfile" in "lab2" which allows you to build image for container
- There are "djangogirls.env" in "lab2" which contains necessary environment variables
- There are "compose.yaml" which allows you to run 2 services, first one to make database, migrations and superuser, if it's necessary, second one will run the app:
    1. You need to create db folder to allow app make database here, and chage UID and GID (default 101, both) for unpriveleged user
        - ```bash
          sudo chown -R 101:101 ${PATH_TO_YOUR_DIRECTORY}/db
          ```
    2. Change volumes directive for both services ```${PATH_TO_YOUR_DIRECTORY}/db:/app/db``` and run a compose:
        - ```bash
          docker compose up -d
          ```

## Lab3
- You need to get whole directory "lab3" to your environment and use it as a build context
 
- There are "Dockerfile" in "lab3" which allows you to build image for container
- There are "djangogirls.env" in "lab3" which contains necessary environment variables
- There are "compose.yaml" which allows you to run 3 services, db to init postgresql instance, one service to make migrations and superuser, if it's necessary, and third one will run the app:
    1. You need to create db folder to allow postgres make database here, be careful with the permissions!
    2. Change volume directive for "db" service and run a compose:
        - ```bash
          docker compose up -d
          ```

