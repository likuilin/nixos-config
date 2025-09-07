# This file has been modified, so please do not use ‘nixos-generate-config’

{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "uas" "sd_mod" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  boot.supportedFilesystems = [ "ntfs" ];

  boot.loader.efi.canTouchEfiVariables = false;
  boot = {
    loader = {
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = false;
      };
    };
  };

  fileSystems."/" =
    { device = "none";
      fsType = "tmpfs";
      options = [ "defaults" "size=16G" "mode=755" ];
    };

  fileSystems."/persist" =
    { device = "/dev/disk/by-label/nixos-persist";
      fsType = "btrfs";
      neededForBoot = true;
    };

  fileSystems."/nix" =
    { depends = [ "/persist" ]; device = "/persist/nix";
      fsType = "none";
      options = [ "bind" ];
    };

  fileSystems."/var/log" =
    { depends = [ "/persist" ]; device = "/persist/log";
      fsType = "none";
      options = [ "bind" ];
    };

  fileSystems."/home" =
    { depends = ["/persist"]; device = "/persist/home";
      fsType = "none";
      options = [ "bind" ];
    };

  fileSystems."/etc/nixos" =
    { depends = [ "/home" ]; device = "/home/kuilin/os/nixos";
      fsType = "none";
      options = [ "bind" ];
    };

  fileSystems."/mnt/btrfsroot" =
    { device = "/dev/disk/by-label/nixos-persist";
      fsType = "btrfs";
      options = [ "subvolid=5" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-label/boot";
      fsType = "ext4";
      options = [ "nofail" ];
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
