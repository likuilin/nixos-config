#!/usr/bin/env bash
#! nixpkgs.bashInteractive nixpkgs.openssl

set -euxo pipefail

sudo -v
openssl enc -d -aes-256-cbc -a -salt -pbkdf2 < autologin.key.enc | sudo dd of=/dev/disk/by-partlabel/autologin

sudo efibootmgr -n 10
sudo reboot
