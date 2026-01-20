{ config, lib, pkgs, ... }:

{
  services.flatpak.enable = true;
  fileSystems."/var/lib/flatpak" =
    { device = "/persist/flatpak";
      fsType = "none";
      options = [ "bind" ];
    };
  users.users.kuilin.extraGroups = [ "flatpak" ];
}
