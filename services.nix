{ config, pkgs, ... }: {
  systemd = { services = { }; };
  services.udisks2.enable = true;
}
