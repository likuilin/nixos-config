# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

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
  swapDevices = [ {device = "/dev/disk/by-label/nixos-swap";} ];

  networking.hostName = "kuilin-outb";

  systemd.services.customStartup = {
    script = ''
      mkdir -p /mnt
      # shred /dev/disk/by-partlabel/autologin
    '';
    wantedBy = [ "local-fs.target" ];
  };

  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  time.timeZone = "America/New_York";

  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.printing.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  users.users.kuilin = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
      kdePackages.kate
    ];
    initialPassword = "p";
  };
  users.motd = "welcome home, kuilin <3\n\n";

  services.displayManager.autoLogin = {enable = true; user = "kuilin";};

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = with pkgs; [
    git
    gparted efibootmgr lshw
    nix-search-cli nix-index comma
    emacs tmux
    wget dig
    htop pv xxd file p7zip pstree killall
    gnupg veracrypt openssl pinentry-curses
  ];
  virtualisation.docker = {
    enable = true;
    daemon.settings.data-root = "/persist/var/lib/docker";
  };

  environment.etc."machine-id".source
    = "/persist/etc/machine-id";

  programs.gnupg.agent.enable = true;

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };
  environment.etc."ssh/ssh_host_rsa_key".source
    = "/persist/etc/ssh/ssh_host_rsa_key";
  environment.etc."ssh/ssh_host_rsa_key.pub".source
    = "/persist/etc/ssh/ssh_host_rsa_key.pub";
  environment.etc."ssh/ssh_host_ed25519_key".source
    = "/persist/etc/ssh/ssh_host_ed25519_key";
  environment.etc."ssh/ssh_host_ed25519_key.pub".source
    = "/persist/etc/ssh/ssh_host_ed25519_key.pub";

  services.tailscale.enable = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?

}
