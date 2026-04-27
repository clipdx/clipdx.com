#!/usr/bin/env sh

cd /root/clipdx.com || exit 1
docker compose down

# NOTE: Below should be exactly what's in ../README.md task server:serve
# Copy the live versions of the keys to the build directory since Docker can't reach down into /etc
cp /etc/letsencrypt/live/clipdx.com/fullchain.pem ~/clipdx.com/nginx/fullchain.pem
cp /etc/letsencrypt/live/clipdx.com/privkey.pem ~/clipdx.com/nginx/privkey.pem
docker compose up --detach --build
