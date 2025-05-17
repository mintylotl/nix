{ config, pkgs, lib, ... }:
let
  HOME = "/home/jwm";
  scriptsDir = "${HOME}/.scripts";
  programsDir = "${HOME}/.programs";
in {
  systemd = {
    user.enable = true;
    #user.startServices = "sd-switch";
    user.sessionVariables = {
      PATH = "/home/jwm/.emacs.d/bin:${scriptsDir}/nginxHtml:$PATH";
    };

    user.services = {
      aria2 = {
        Install = { WantedBy = [ "default.target" ]; };
        Service = {
          ProtectSystem = lib.mkForce "off";
          Type = "simple";
          Environment =
            ''LD_LIBRARY_PATH="${pkgs.aria2.out}/lib:$LD_LIBRARY_PATH"'';
          ExecStart =
            "${pkgs.aria2.bin}/bin/aria2c --conf-path=${programsDir}/aria2/aria2.conf";
        };
        Unit = { Description = "Aria2 Daemon"; };
      };
      nginx_html = {
        Unit = { Description = "Nginx HTML regenerator service"; };
        Service = {
          ExecStart = "${scriptsDir}/nginxHtml/nginx_html.sh";
          Restart = "always";
        };
        Install = { WantedBy = [ "default.target" ]; };
      };
      anki_sync = {
        Unit = { Description = "Anki-Sync Daemon"; };
        Service = {
          ExecStart =
            "${pkgs.bash}/bin/bash -l -c '${programsDir}/anki_sync.sh'";
          Restart = "on-failure";
        };
        Install = { WantedBy = [ "default.target" ]; };
      };
      loadsheddingnotifier = {
        #Service = {
        #ExecStart =
        #  "${pkgs.bash}/bin/bash -l -c '/home/jwm/.scripts/programs/loadshed/run.sh'";
        #};
        #Install = { WantedBy = [ "default.target" ]; };
      };
    };
  };
}
