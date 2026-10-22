{
  config,
  pkgs,
  lib,
  ...
}:
let
  HOME = "/home/jwm";
  scriptsDir = "${HOME}/.scripts";
  programsDir = "${HOME}/.programs";
in
{
  systemd = {
    user.enable = true;
    #user.startServices = "sd-switch";
    user.sessionVariables = {
      PATH = "/home/jwm/.emacs.d/bin:$PATH";
    };

    user.services = {
      nginx_html = {
        Unit = {
          Description = "Nginx HTML regenerator service";
        };
        Service = {
          ExecStart = "${pkgs.bash}/bin/bash -lc '${scriptsDir}/nginxhtml/nginx_html.sh'";
          Restart = "on-failure";
        };
        Install = {
          WantedBy = [ "default.target" ];
        };
      };
      anki_sync = {
        Unit = {
          Description = "Anki-Sync Daemon";
        };
        Service = {
          ExecStart = "${pkgs.bash}/bin/bash -lc '${programsDir}/anki_sync.sh'";
          Restart = "on-failure";
        };
        Install = {
          WantedBy = [ "default.target" ];
        };
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
