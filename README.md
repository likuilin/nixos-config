# nixos-config

NixOS is good :)

```
[kuilin@kuilin-outb:~/nixos]$ lsblk -o name,size,fstype,label,partlabel,mountpoints
NAME                SIZE FSTYPE      LABEL         PARTLABEL     MOUNTPOINTS
sda               238.5G
└─sda1               32M                           autologin
sdb                 7.3T
├─sdb1              512M vfat                      recovery-boot
├─sdb2               32G ext4        recovery-root recovery-root
└─sdb3              7.2T crypto_LUKS               green-crypt
nvme0n1           931.5G
├─nvme0n1p1         512M vfat        BOOT          boot          /boot
└─nvme0n1p2         931G crypto_LUKS               nixos
  └─cryptroot       931G LVM2_member
    ├─vg-swap        64G swap        nixos-swap                  [SWAP]
    ├─vg-nix         32G ext4        nixos-nix                   /nix
    ├─vg-log         32G ext4        nixos-log                   /var/log
    ├─vg-persist     32G ext4        nixos-persist               /persist
    └─vg-home        32G ext4        nixos-home                  /home
```
