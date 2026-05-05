# Computers Like Portland Website

![portland flag glitched](web/entries/assets/portland-flag-glitched.png)

Live at https://clipdx.com

## Development Setup

To SSH (or rsync) onto the website, you will need your public SSH keys on the server. Speak with management.

You can run the scripts below (Tasks) easily with [`xc`](https://xcfile.dev), or just copy
them to your terminal. Some lines below like `interactive: true` are for `xc`.

```
sudo apt install rsync
```

## New server setup

Very unlikely these steps are exactly reproduceable, so read this more like a notebook than a script to run. Shouldn't need to run this more than once on a new VM. These are all tested on a Hetzner Cloud instance running Ubuntu 24.04.

NOTE: My (Hetzner owner's) SSH keys are placed in automatically by virtue of being installed in the Hetzner console. But for other people's keys, manual step necessary to put into server's `~/.ssh/authorized_keys`.

NOTE: Also on a new server will need to set up LetsEncrypt for SSL certificates. See [`hetzner-letsencrypt/README`](./hetzner-letsencrypt/README.md)

```sh
# The fresh server image isn't immediately up to date, so start with an upgrade
apt update && apt upgrade

# Docker from https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository
# NOTE: Need to run the big script to add Docker's `apt` repository before these
apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# This should already be enabled, but worth pointing out this is how `restart: always` in docker-compose.yml will restart the Docker container after the esrver machine reboots.
sudo systemctl enable docker

# Golang for XC https://xcfile.dev/getting-started/#installation
curl -L -O https://go.dev/dl/go1.26.2.linux-amd64.tar.gz
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.26.2.linux-amd64.tar.gz
rm go1.26.2.linux-amd64.tar.gz
/usr/local/go/bin/go version
# Ensure gopath is in .bashrc: export PATH=$PATH:/usr/local/go/bin

# XC
go install github.com/joerdav/xc/cmd/xc@latest
# Ensure GOPATH and bin are in .bashrc:
# export GOPATH=$HOME/go
# export PATH=$PATH:$GOPATH/bin
xc --version
```

## Tasks

These are the development script snippets.

[![xc compatible](https://xcfile.dev/badge.svg)](https://xcfile.dev)

Note: scripts prefixed with `local:` are meant to be run from your personal computer. Scripts prefixed with `server:` are meant to be run on the server box.

### server:serve

When logged into the server (`ssh <user>@clipdx.com`), and in the `clipdx.com` directory, do `xc server:serve` to run this.

Updates and runs/restarts the `Docker` containers. This should not be necessary for normal web updates, as the built website is bind-mounted into the container.

```sh
docker compose up --detach --build
```

### server:logs

Watch the docker logs. `-f` is for "follow", like `tail -f`.

```sh
docker compose logs -f
```

### local:upload

Uploads local contents to the correct place on the server for normal operation.

Note you must run `local:web-build` before this for any updates to the website to appear.

Any changes to the website will immediately appear (i.e. on refresh of the webpage)

```sh
rsync -rav . root@clipdx.com:/root/clipdx.com/ --exclude=.git --exclude=web
rsync -rav ./web/build/ root@clipdx.com:/root/clipdx.com/web-build/
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

### local:update-html-wiki

[@reedspool/html-wiki](https://github.com/reedspool/html-wiki) updates often enough that want a quick way to do this.

```sh
cd web/
npm remove @reedspool/html-wiki && \
  npm install @reedspool/html-wiki
```
