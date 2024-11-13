{ config, pkgs, ... }: {
  systemd = {
    user.services = { };
    services = { };
  };
  services.emacs = {
    enable = true;
    client.enable = true;
    defaultEditor = true;

    startWithUserSession = true;
  };
}
