{ config, pkgs, lib, ... }:
let HOME = "/home/jwm";
in {
  systemd = {
    user.enable = true;
    user.startServices = "sd-switch";

    user.sessionVariables = {
      PATH =
        "/run/current-system/sw/bin:/home/jwm/.emacs.d/bin:/home/jwm/.scripts/scripts/nginxHtml:$PATH";
    };

    user.services = {
      aria2 = {
        Install = { WantedBy = [ "multi-user.target" ]; };
        Service = {
          ProtectSystem = lib.mkForce "off";
          Type = "simple";
          Environment = ''PATH="${pkgs.aria2.out}/lib"'';
          ExecStart =
            "${pkgs.aria2.bin}/bin/aria2c --conf-path=${HOME}/.scripts/programs/aria2/aria2.conf";
        };
        Unit = { Description = "Aria2 Daemon"; };
      };
      nginx_html = {
        Unit = { Description = "Nginx HTML regenerator service"; };
        Service = {
          ExecStart = "/home/jwm/.scripts/scripts/nginxHtml/nginx_html.sh";
          Restart = "always";
        };
        Install = { WantedBy = [ "default.target" ]; };
      };
    };
  };
}
