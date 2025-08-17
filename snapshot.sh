#!/usr/bin/env bash
#! nixpkgs.bashInteractive

set -euxo pipefail

sudo -v
[[ "$1" != *\/* ]]

cd /mnt/btrfsroot/boot
[[ ! -e @$1 ]]
sudo btrfs sub snap @ @$1
cd @$1
sudo dd if=/dev/disk/by-label/EFI of=efi.bin status=progress

cd /mnt/btrfsroot/nixos
[[ ! -e @$1 ]]
sudo btrfs sub snap @ @$1
