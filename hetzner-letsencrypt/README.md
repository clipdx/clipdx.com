# Certbot LetsEncrypt on Hetzner

Scripts based on https://community.hetzner.com/tutorials/letsencrypt-dns

I manually wrote the token at `/etc/hetzner-dns-token` as the tutorial says, but does it make sense for it to live here, or should I put this somewhere else? Either way want to remember this location in case I have to update the token.

## Tasks

[![xc compatible](https://xcfile.dev/badge.svg)](https://xcfile.dev)

### install

```sh
apt install curl jq certbot
```

### make-request

```sh
chmod +x *.sh
./make-request.sh
```

### setup-crontab

From https://certbot.eff.org/instructions?ws=nginx&os=opbsd6&tab=wildcard

Added post-install script to restart my server and rebuild to include the updated SSL key files.

```sh
echo "0 0,12 * * * root python3 -c 'import random; import time; time.sleep(random.random() * 3600)' && sudo certbot renew -q --post-hook /root/clipdx.com/hetzner-letsencrypt/post-renew.sh" | sudo tee -a /etc/crontab > /dev/null
```
