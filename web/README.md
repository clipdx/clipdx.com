# clipdx.com website

The `entries` directory is the source HTML. This is processed by [`@reedspool/html-wiki`](https://github.com/reedspool/html-wiki) into the `build` directory.

The `build` directory is `.gitignore`'d. This directory is ephemeral in that `html-wiki` wipes it out, so don't make edits there. The `build` dir gets copied into the `nginx` directory in `../README.md`'s task `local:upload`
