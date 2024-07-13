FROM lucee:5.4-nginx

WORKDIR /

COPY /nginx/default.conf /etc/nginx/conf.d/default.conf
COPY /nginx/nginx.conf /etc/nginx/nginx.conf
COPY /web/www /var/www

RUN apt-get update
RUN apt-get install nano
# RUN apt-get -y install docker.io

EXPOSE 99
EXPOSE 80
EXPOSE 443