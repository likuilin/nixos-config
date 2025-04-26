#!/usr/bin/env bash

set -euxo pipefail

sudo umount /mnt/green-data
sudo vgchange -an green
sudo cryptsetup luksClose green-crypt
