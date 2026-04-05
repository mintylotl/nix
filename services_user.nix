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
      #aria2 = {
      #  Unit = {
      #    Description = "Aria2 Daemon";
      #  };
      #  Service = {
      #    ProtectSystem = lib.mkForce "off";
      #    Type = "simple";
      #    Environment = ''LD_LIBRARY_PATH="${pkgs.aria2.out}/lib:$LD_LIBRARY_PATH"'';
      #    ExecStart = "${pkgs.aria2.bin}/bin/aria2c --conf-path=${programsDir}/aria2/aria2.conf";
      #  };
      #  Install = {
      #    WantedBy = [ "default.target" ];
      #  };
      #};
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
      gacha_life = {
        Unit = {
          Description = "GachaLife Daemon";
        };
        Service = {
          ExecStart = "${pkgs.bash}/bin/bash -lc '${programsDir}/gacha_life.sh'";
          Environment = "TELOXIDE_TOKEN=8323998090:AAGX7RIyCIUlf-q_2xRkORN_Cqi2b-bq4Dw";
          ExecStopPost = "${pkgs.bash}/bin/bash -lc '${programsDir}/gacha_life.sh 1'";
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
