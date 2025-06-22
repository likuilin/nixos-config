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
      firefox ungoogled-chromium

      thunderbird
      discord discord-canary discord-ptb

      # daemon
      synergy
      spotify
      urlwatch
    ];
    initialPassword = "p";
    shell = pkgs.fish;
  };
  security.sudo.extraConfig = ''
    Defaults lecture = never
  '';
  services.displayManager.autoLogin = {enable = true; user = "kuilin";};
}
