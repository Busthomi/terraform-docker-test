FROM nginx:alpine

RUN mkdir -p /var/www
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY hello.txt /var/www/

EXPOSE 80