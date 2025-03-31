{ config, lib, pkgs, ... }:

{
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  services.tailscale.enable = true;
  fileSystems."/var/lib/tailscale" =
    { device = "/persist/var/lib/tailscale";
      fsType = "none";
      options = [ "bind" ];
    };

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

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
  };
}
