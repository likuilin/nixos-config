#!/usr/bin/env fish

function close
  sudo umount /mnt/green-data; or return 1
  sudo vgchange -an green; or return 1
  sudo cryptsetup luksClose green-crypt; or return 1
end

fish_trace=1 close
