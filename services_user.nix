{ config, pkgs, lib, ... }:
let HOME = "/home/jwm";
in {
  systemd = {
    user.enable = true;
    #user.startServices = "sd-switch";

    user.sessionVariables = {
      PATH =
        "/run/current-system/sw/bin:/home/jwm/.emacs.d/bin:/home/jwm/.scripts/scripts/nginxHtml:$PATH";
    };

    user.services = {
      aria2 = {
        Install = { WantedBy = [ "default.target" ]; };
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
      anki_sync = {
        Unit = { Description = "Anki-Sync Daemon"; };
        Service = {
          ExecStart =
            "${pkgs.bash}/bin/bash -l -c '/home/jwm/.scripts/programs/anki_sync.sh'";
          Restart = "on-failure";
        };
        Install = { WantedBy = [ "default.target" ]; };
      };
      loadsheddingnotifier = {
        Service = {
          #ExecStart =
          #  "${pkgs.bash}/bin/bash -l -c '/home/jwm/.scripts/programs/loadshed/run.sh'";
        };
        Install = { WantedBy = [ "default.target" ]; };
      };
    };
  };
}
