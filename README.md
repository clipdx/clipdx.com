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

### upload

```sh
rsync -rav . root@clipdx.com:/root/clipdx.com/ --exclude=.git
```
