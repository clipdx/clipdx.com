# Computers Like Portland Website

Live at https://clipdx.com

## Development Setup

To SSH (or rsync) onto the website, you will need your public SSH keys on the server. Speak with management.

You can run the scripts below (Tasks) easily with [`xc`](https://xcfile.dev), or just copy
them to your terminal. Some lines below like `interactive: true` are for `xc`.

```
sudo apt install rsync
```

## Tasks

These are the development script snippets.

[![xc compatible](https://xcfile.dev/badge.svg)](https://xcfile.dev)

Note: scripts prefixed with `local:` are meant to be run from your personal computer. Scripts prefixed with `server:` are meant to be run on the server box.

### server:install

```sh
# Docker from https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Go for https://xcfile.dev/getting-started/#installation
curl -L -O https://go.dev/dl/go1.26.2.linux-amd64.tar.gz
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.26.2.linux-amd64.tar.gz
rm go1.26.2.linux-amd64.tar.gz
/usr/local/go/bin/go version
# Ensure gopath is in .bashrc: export PATH=$PATH:/usr/local/go/bin

# XC
/usr/local/go install github.com/joerdav/xc/cmd/xc@latest
# Ensure GOPATH is in .bashrc: export GOPATH=$HOME/go
# Ensure GOPATH bin is in .bashrc: export PATH=$PATH:$GOPATH/bin
xc --version
```

### server:serve

NOTE: If this is updated, it must be updated in `hetzner-letsencrypt/post-renew.sh` as well. Could probably just call `xc` from in there, but I didn't want to risk any additional variables to the auto renew process at time of writing until I'd seen it work once or twice, after a month or two.

```sh
# Copy the live versions of the keys to the build directory since Docker can't reach down into /etc
cp /etc/letsencrypt/live/clipdx.com/fullchain.pem ~/clipdx.com/nginx/fullchain.pem
cp /etc/letsencrypt/live/clipdx.com/privkey.pem ~/clipdx.com/nginx/privkey.pem
docker compose up --detach --build
```

### server:logs

```sh
docker compose logs -f # -f for tail
```

### local:upload

Uploads local contents to the correct place on the server for normal operation.

Note you must run `local:web-build` before this for any updates to the website to appear.

Note you must run `server:serve` on the server after this for updates to appear.

```sh
rsync -rav . root@clipdx.com:/root/clipdx.com/ --exclude=.git --exclude=web
rsync -rav ./web/build/ root@clipdx.com:/root/clipdx.com/nginx/site/
```

### local:web-serve

For local development, it's nice to run the website locally.

```sh
cd web/
DEBUG=* npx html-wiki server -u entries --port 3142
```

### local:web-build

```sh
cd web/
rm -rf build
mkdir build
DEBUG=* npx html-wiki generate -u entries -o build
```
