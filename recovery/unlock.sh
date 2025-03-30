#!/usr/bin/env bash
#! nixpkgs.bashInteractive nixpkgs.openssl

openssl enc -d -aes-256-cbc -a -salt -pbkdf2 < autologin.img.enc | sudo dd of=/dev/sda
