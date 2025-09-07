#!/usr/bin/env bash
#! nixpkgs.bashInteractive

set -euxo pipefail

sudo -v
[[ "$1" != *\/* ]]

cd /mnt/btrfsroot
[[ ! -e @$1 ]]
sudo btrfs sub snap @ @$1
cd @$1
sudo tar czvf boot.tgz /boot

echo "snapshot saved:" $(pwd)
