{ config, lib, pkgs, ... }:

{
  users.users.kuilin = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
      kdePackages.kate
    ];
    initialPassword = "p";
  };
  security.sudo.extraConfig = ''
    Defaults lecture = never
  '';
  services.displayManager.autoLogin = {enable = true; user = "kuilin";};
}
