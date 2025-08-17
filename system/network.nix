{ config, lib, pkgs, ... }:

{
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  services.tailscale.enable = true;
  fileSystems."/var/lib/tailscale" =
    { device = "/persist/tailscale";
      fsType = "none";
      options = [ "bind" ];
    };

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      X11Forwarding = true;
    };
  };
  programs.ssh.setXAuthLocation = true;

  environment.etc."ssh/ssh_host_rsa_key".source
    = "/persist/sshd/ssh_host_rsa_key";
  environment.etc."ssh/ssh_host_rsa_key.pub".source
    = "/persist/sshd/ssh_host_rsa_key.pub";
  environment.etc."ssh/ssh_host_ed25519_key".source
    = "/persist/sshd/ssh_host_ed25519_key";
  environment.etc."ssh/ssh_host_ed25519_key.pub".source
    = "/persist/sshd/ssh_host_ed25519_key.pub";

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
  };

  security.pki.certificates = [ ''
    kuilin
    =========
    -----BEGIN CERTIFICATE-----
    MIIDuzCCAqOgAwIBAgIUIGtS8AnxH9QeC3QFWV6WtoMMypUwDQYJKoZIhvcNAQEL
    BQAwbDELMAkGA1UEBhMCVVMxDzANBgNVBAMMBmt1aWxpbjEgMB4GCSqGSIb3DQEJ
    ARYRa3VpbGluQGt1aWxpbi5uZXQxKjAoBglghkgBhvhCAQ0MG1NlZSBodHRwczov
    L2t1aWxpbi5uZXQveDUwOTAgFw0yMDAxMDEwMDAwMDBaGA8yMTIwMDEwMTAwMDAw
    MFowbDELMAkGA1UEBhMCVVMxDzANBgNVBAMMBmt1aWxpbjEgMB4GCSqGSIb3DQEJ
    ARYRa3VpbGluQGt1aWxpbi5uZXQxKjAoBglghkgBhvhCAQ0MG1NlZSBodHRwczov
    L2t1aWxpbi5uZXQveDUwOTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEB
    AMKrQ+pFxxe5BF4EuER/uLloGi5xDa4XM+zv1yQfjSKwbLqtE6G7YOv1XM+b+TYQ
    qrCp6XRYBpN7fRtJzFUMTzIvcabhhupQfipSABt8rhtcYOBsbhMDMhOTu5xX4BGY
    Jbvs88ZP410SEN2IYr1wdgCjDgdLMje9QTdNJn2vMH1e6eMkjJdNKjamCTQF/yDd
    Zut2Zm3EO7jf180Rk83DkKJoiX76VxyL8wycVhQO9+ynWtIIx39+86bUUz0aTGs8
    D6r5m5+BSZ0K79D4OvxP1RD0B9jVSe8ma2yEhvt8oGWhsmN1NlWni/QURYKkV1YV
    geWCWBTkRugUA2lYsUIKEKMCAwEAAaNTMFEwHQYDVR0OBBYEFAmXbC1oXmqhPFeK
    5ucJYdrHrWGoMB8GA1UdIwQYMBaAFAmXbC1oXmqhPFeK5ucJYdrHrWGoMA8GA1Ud
    EwEB/wQFMAMBAf8wDQYJKoZIhvcNAQELBQADggEBALkP1ziZTw6LxmAmvlgTw+37
    DdIE4lTISu12ZPYAnUjCPopydMMIrGbpsiT5fBIzpggiskVkRbmlJnioGsb5MfeZ
    WOfAjRVUg/rRAeg7V0SJH0gJFw0cgCoY1tqoN0EJ/tnHLGEFhOvuvsB++Q6BCGis
    3pT3YZ9cdoW1LYCsetO248bscKvuZdrYf9WfhQVdxWrnR5ibmiDtIacOFKiCZUXD
    OzLA+bPAXdGS2DyXxQnhfMQyEdhh4oMfPQS+eXA7FE0Ya4e9ezKrknJAnMqTMZH0
    aNzJZ+b63MLDZi8pCpD+OspFyyLp0cQ1NUwZjV40cfEAADczYoRfzHO5URiwrCU=
    -----END CERTIFICATE-----
  '' ];
}
