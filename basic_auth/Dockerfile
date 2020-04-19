FROM nginx:1.17

RUN apt-get update -yqq && \
    apt-get install -y apache2-utils

RUN htpasswd -b -c /etc/nginx/.htpasswd username password
