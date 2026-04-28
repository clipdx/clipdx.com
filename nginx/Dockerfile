FROM nginx:latest

# ./site placed by README.md task local:upload
COPY ./site /usr/share/nginx/html/
RUN chmod -R 755 /usr/share/nginx/html

COPY ./nginx.conf /etc/nginx/conf.d/default.conf

# Copy the local copy (See README Tasks server:serve) to an arbitrary location (used in nginx.conf)
COPY --chmod=644 fullchain.pem /etc/letsencrypt/clipdx.com/fullchain.pem
COPY --chmod=600 privkey.pem /etc/letsencrypt/clipdx.com/privkey.pem
