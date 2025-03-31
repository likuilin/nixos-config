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

  boot.loader.efi.canTouchEfiVariables = false;
  boot = {
    loader = {
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
      };
    };

    initrd.luks.devices.cryptroot = {
      device = "/dev/disk/by-partlabel/nixos";
      keyFileSize = 4096;
      keyFile = "/dev/disk/by-partlabel/autologin"; # for remote login after reboot
      fallbackToPassword = true;
    };
  };

  systemd.services.customStartup = {
    script = ''
      mkdir -p /mnt
      shred /dev/disk/by-partlabel/autologin
    '';
    wantedBy = [ "local-fs.target" ];
  };

  fileSystems."/" =
    { device = "none";
      fsType = "tmpfs";
      options = [ "defaults" "size=16G" "mode=755" ];
    };

  fileSystems."/nix" =
    { device = "/dev/disk/by-label/nixos-nix";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-label/BOOT";
      fsType = "vfat";
      options = [ "fmask=0133" "dmask=0022" ];
    };

  fileSystems."/var/log" =
    { device = "/dev/disk/by-label/nixos-log";
      fsType = "ext4";
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-label/nixos-home";
      fsType = "ext4";
    };

  fileSystems."/etc/nixos" =
    { device = "/home/kuilin/nixos";
      fsType = "none";
      options = [ "bind" ];
    };

  fileSystems."/persist" =
    { device = "/dev/disk/by-label/nixos-persist";
      fsType = "ext4";
    };

  swapDevices = [ {device = "/dev/disk/by-label/nixos-swap";} ];

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
