{ inputs, config, pkgs, ... }:
{
  systemd.services.aria2 = {
    enable = false;

    serviceConfig = {
      ProtectSystem = "off";
      ExecStart = "\"/nix/store/w38nh1fzj9rl1in0w72v5xrnlnb4ia8b-aria2-1.37.0-bin/bin/aria2c\" --conf-path=/system/programs/aria2/aria2.conf";
      UMask = "0077";
      User="aria2";
      Group="aria2";
    };
    wantedBy = [ "default.target" ];
  };
}
