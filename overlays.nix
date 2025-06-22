self: super: {
  urlwatch = super.urlwatch.overrideAttrs (oldAttrs: {
    postInstall = (oldAttrs.postInstall or "") + ''
      wrapProgram $out/bin/urlwatch --set REQUESTS_CA_BUNDLE /etc/ssl/certs/ca-certificates.crt
    '';
  });
}
