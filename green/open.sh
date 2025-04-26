#!/usr/bin/env bash

set -euxo pipefail

sudo cryptsetup luksOpen /dev/disk/by-partlabel/green-crypt green-crypt
sudo partprobe
sudo mount /dev/disk/by-label/green-data /mnt/green-data
