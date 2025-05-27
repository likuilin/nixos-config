#!/usr/bin/env fish

function open
  sudo cryptsetup luksOpen /dev/disk/by-partlabel/green-crypt green-crypt; or return 1
  sudo partprobe
  while not test -e /dev/disk/by-label/green-data
    sleep 1
  end
  sudo mount /dev/disk/by-label/green-data /mnt/green-data
end

fish_trace=1 open
