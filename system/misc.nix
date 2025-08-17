{ config, lib, pkgs, ... }:

{
  environment.etc."machine-id".source
    = "/persist/machine-id";

  environment.systemPackages = with pkgs; [
    git
    gparted efibootmgr lshw hdparm smartmontools gptfdisk parted
    emacs tmux
    wget dig
    htop iotop pv xxd file p7zip pstree killall tree lsof
    gnupg openssl pinentry-curses
    moreutils
  ];
  virtualisation.docker = {
    enable = true;
    daemon.settings.data-root = "/persist/docker";
  };

  services.cron.enable = true;
  fileSystems."/var/cron" =
    { device = "/persist/cron";
      fsType = "none";
      options = [ "bind" ];
    };

  # services.printing.enable = true;

  programs.fish.enable = true;

  programs.adb.enable = true;
  services.orca.enable = true;
}
