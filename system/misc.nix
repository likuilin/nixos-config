{ config, lib, pkgs, ... }:

{
  environment.etc."machine-id".source
    = "/persist/etc/machine-id";

  environment.systemPackages = with pkgs; [
    git
    gparted efibootmgr lshw hdparm smartmontools gptfdisk parted
    emacs tmux
    wget dig
    htop iotop pv xxd file p7zip pstree killall
    gnupg veracrypt openssl pinentry-curses
  ];
  virtualisation.docker = {
    enable = true;
    daemon.settings.data-root = "/persist/var/lib/docker";
  };

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

  programs.adb.enable = true;
}
