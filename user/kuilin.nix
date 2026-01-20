{ config, lib, pkgs, ... }:

{
  users.users.kuilin = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "docker" "adbusers" ];
    packages = with pkgs; [
      # cli
      nix-search-cli nix-index comma
      reptyr

      # mobile
      scrcpy

      # gui
      firefox

      discord discord-canary discord-ptb

      vlc

      remmina

      # daemon
      synergy
      spotify
      urlwatch

      # tools
      ffmpeg
    ];
    initialPassword = "p";
    shell = pkgs.fish;
  };
  security.sudo.extraConfig = ''
    Defaults lecture = never
  '';
  services.displayManager.autoLogin = {enable = true; user = "kuilin";};
}
