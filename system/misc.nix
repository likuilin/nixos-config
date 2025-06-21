{ config, lib, pkgs, ... }:

{
  environment.etc."machine-id".source
    = "/persist/etc/machine-id";

  environment.systemPackages = with pkgs; [
    git
    gparted efibootmgr lshw hdparm smartmontools gptfdisk parted
    emacs tmux
    wget dig
    htop iotop pv xxd file p7zip pstree killall tree lsof
    gnupg veracrypt openssl pinentry-curses
  ];
  virtualisation.docker = {
    enable = true;
    daemon.settings.data-root = "/persist/var/lib/docker";
  };

  services.printing.enable = true;

  programs.adb.enable = true;
  programs.fish.enable = true;

  services.orca.enable = true;
}
