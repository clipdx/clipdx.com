#!/usr/bin/env sh

sudo certbot certonly --manual --preferred-challenges=dns --manual-auth-hook ./auth.sh --manual-cleanup-hook ./cleanup.sh -d reeds.website -d '*.clipdx.com'
