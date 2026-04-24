FROM nginx:latest
COPY ./example.html /usr/share/nginx/html/example.html

RUN chmod -R 755 /usr/share/nginx/html
COPY ./nginx.conf /etc/nginx/conf.d/default.conf
