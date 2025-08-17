# This file has been modified, so please do not use ‘nixos-generate-config’

{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  boot.supportedFilesystems = [ "ntfs" ];

  boot = {
    loader = {
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        fsIdentifier = "label";
      };
      efi = {
        canTouchEfiVariables = false;
        efiSysMountPoint = "/boot/efi";
      };
    };

    initrd.luks.devices.cryptroot = {
      device = "/dev/disk/by-partlabel/root";
      keyFileSize = 4096;
      keyFile = "/dev/disk/by-partlabel/autologin"; # for remote login after reboot
      fallbackToPassword = true;
    };
  };

  systemd.services.customStartup = {
    script = ''
      mkdir -p /mnt/mnt /mnt/mnt2 /mnt/green-data
      shred /dev/disk/by-partlabel/autologin
    '';
    wantedBy = [ "local-fs.target" ];
  };

  fileSystems."/" =
    { device = "none";
      fsType = "tmpfs";
      options = [ "defaults" "size=16G" "mode=755" ];
    };

  fileSystems."/persist" =
    { device = "/dev/disk/by-label/nixos";
      fsType = "btrfs";
      neededForBoot = true;
    };
  fileSystems."/nix" =
    { depends = [ "/persist" ]; device = "/persist/nix";
      fsType = "none";
      options = [ "bind" ]; neededForBoot = true;
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-label/boot";
      fsType = "btrfs";
    };
  fileSystems."/boot/efi" =
    { device = "/dev/disk/by-label/EFI";
      fsType = "vfat";
      options = [ "fmask=0133" "dmask=0022" ];
    };

  fileSystems."/home" =
    { depends = [ "/persist" ]; device = "/persist/home";
      fsType = "none";
      options = [ "bind" ];
    };
  fileSystems."/var/log" =
    { depends = [ "/persist" ]; device = "/persist/log";
      fsType = "none";
      options = [ "bind" ];
    };
  fileSystems."/etc/nixos" =
    { depends = [ "/home" ]; device = "/home/kuilin/os/nixos";
      fsType = "none";
      options = [ "bind" ];
    };
  fileSystems."/mnt/btrfsroot/nixos" =
    { device = "/dev/vg/nixos";
      fsType = "btrfs";
      options = [ "subvolid=5" ];
    };
  fileSystems."/mnt/btrfsroot/boot" =
    { device = "/dev/disk/by-label/boot";
      fsType = "btrfs";
      options = [ "subvolid=5" ];
    };

  swapDevices = [ {device = "/dev/vg/swap";} ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp2s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp3s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
