{ lib, config, pkgs, ... }:
let
HOME = "/home/jwm";
in
{
  systemd.user.services.aria2 = {
    enable = true;
    unitConfig.ConditionUser = "jwm";
    serviceConfig = {
      ProtectSystem = lib.mkForce "off";
      Type = "simple";
      Environment = "${pkgs.aria2.out}/lib";
      ExecStart = "${pkgs.aria2.bin}/bin/aria2c --conf-path=${HOME}/.scripts/programs/aria2/aria2.conf";
    };
    wantedBy = [ "default.target" ];
  };

  users.users.aria2 = {
    isNormalUser = true;
    group = "aria2";
  };
}
