#!/bin/sh
#
# This script syncs the clipdx.com server files but not the content.
# Run it from the base of the checked-out git repo to push current files live.
# It will do a "check" pass, ask for confirmation, then proceed with the sync.
#

set -e
export RSYNC_SSH="tailscale ssh"

do_rsync() {
  cmd="rsync -rv --checksum $@ \
    --exclude '.git/' \
    --exclude '.idea/' \
    --exclude 'util/' \
    --exclude 'web/' \
    . root@clipdx-com:clipdx.com"
  echo "+ ${cmd}" | tr -s " "
  eval ${cmd}
}

do_confirm_yn() {
  while : ; do
    echo ""
    echo -n "$@ (y/n) : "
    read ans
    case "$ans" in
      [yY]*) return ;;
      [nN]*) echo "Aborted." ; exit 0 ;;
    esac
    echo "Answer 'y' or 'n'."
  done
}

echo "=== DRY RUN ==="
do_rsync --dry-run
do_confirm_yn "OK to proceed?"
do_rsync
echo ""
echo "Done."

