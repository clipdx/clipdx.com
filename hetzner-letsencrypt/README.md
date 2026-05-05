# Certbot LetsEncrypt on Hetzner

Scripts based on https://community.hetzner.com/tutorials/letsencrypt-dns

After I generated the Hetzner API token, I stored it in my password manager. Then I manually wrote the token at `/etc/hetzner-dns-token` as the tutorial says. Does it make sense for it to live here, or should I put this somewhere else? Either way want to remember this location in case I have to update the token.

Note that the output of `./make-request` states `Certbot has set up a scheduled task to automatically renew this certificate in the background.` Therefore, if that's true, these steps should only be required once on server-setup.

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
