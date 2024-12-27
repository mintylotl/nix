{ config, pkgs, ... }: {
  systemd = {
    services = {
      mounts = {
        after = [ "emacs-mounts.service" ];
        wantedBy = [ "multi-user.target" ];
        description = "Drives and Volume Mounter";
        path = [ pkgs.util-linux pkgs.coreutils ];

        serviceConfig = {
          ExecStart = "${pkgs.bash}/bin/bash /system/scripts/mounts.sh";
          ProtectHome = false;
          ProtectSystem = false;
        };
      };

      emacs-mounts = {
        wantedBy = [ "multi-user.target" ];
        description = "Mounts Emacs's Paths";
        path = [ pkgs.util-linux pkgs.coreutils ];

        serviceConfig = {
          ExecStart = "${pkgs.bash}/bin/bash /system/scripts/mounts.sh 1";
          ProtectSystem = false;
          ProtectHome = false;
          WorkingDirectory = "/home/jwm";
        };
      };

      emacs = {
      	enable = false;
        after = [ "emacs-mounts.service" ];
        wantedBy = [ "multi-user.target" ];
        description = "Emacs Daemon Service";

        serviceConfig = {
          ProtectHome = false;
          PrivateTmp = false;
          WorkingDirectory = "/home/jwm";
          ExecStart =
            "${pkgs.bash}/bin/bash -l -c 'emacs --fg-daemon'";
          User = "jwm";
          Group = "jwm";
        };
      };
    };
  };
  services.udisks2.enable = true;
}
