{ config, lib, pkgs, ... }:

{
  users.users.kuilin = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "docker" "adbusers" ];
    packages = with pkgs; [
      # cli
      nix-search-cli nix-index comma

      # mobile
      scrcpy

      # gui
      firefox ungoogled-chromium

      thunderbird
      discord discord-canary discord-ptb

      # daemon
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
