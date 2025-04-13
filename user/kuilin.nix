{ config, lib, pkgs, ... }:

{
  users.users.kuilin = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "docker" "adbusers" ];
    packages = with pkgs; [
      # cli
      nix-search-cli nix-index comma
      scrcpy

      # gui
      ungoogled-chromium

      thunderbird
      discord discord-canary discord-ptb

      synergy
      spotify
    ];
    initialPassword = "p";
  };
  security.sudo.extraConfig = ''
    Defaults lecture = never
  '';
  services.displayManager.autoLogin = {enable = true; user = "kuilin";};
}
