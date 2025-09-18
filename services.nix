{ config, pkgs, ... }:
{
  systemd = {
    services = {
      alice = {
        description = "A service for running the Alice Bot";
        after = [ "network-online.target" ];
        requires = [ "network-online.target" ];
        wantedBy = [ "multi-user.target" ];
        path = with pkgs; [ openjdk ];

        serviceConfig = {
          WorkingDirectory = "/system/programs/alice";
          ExecStart = "/run/current-system/sw/bin/java -jar ./alice.jar";
        };
      };

      komf = {
        description = "Komf service for fetching Komga metadata";
        wantedBy = [ "multi-user.target" ];
        path = with pkgs; [ openjdk ];

        serviceConfig = {
          User = "komga";
          Group = "komga";

          WorkingDirectory = "/system/programs/komga/komf";
          ExecStart = "/run/current-system/sw/bin/java -jar ./komf.jar application.yaml";
        };
      };

      postgres-init = {
        description = "Ensure /run/postgresql exists";
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          Type = "oneshot";
          ExecStart = "/run/current-system/sw/bin/mkdir -p /run/postgresql";
          ExecStartPost = "${pkgs.bash}/bin/bash -c '/run/current-system/sw/bin/chown jwm:jwm /run/postgresql && /run/current-system/sw/bin/chmod 775 /run/postgresql'";
        };
      };

      mounts = {
        after = [ "emacs-mounts.service" ];
        wantedBy = [ "multi-user.target" ];
        description = "Drives and Volume Mounter";
        path = [
          pkgs.util-linux
          pkgs.coreutils
          pkgs.hdparm
        ];

        serviceConfig = {
          ExecStart = "${pkgs.bash}/bin/bash /system/scripts/mounts.sh";
          ProtectHome = false;
          ProtectSystem = false;
        };
      };

      emacs-mounts = {
        wantedBy = [ "multi-user.target" ];
        description = "Mounts Emacs's Paths";
        path = [
          pkgs.util-linux
          pkgs.coreutils
        ];

        serviceConfig = {
          Before = [ "emacs.service" ];
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
          ExecStart = "${pkgs.bash}/bin/bash -l -c 'emacs --fg-daemon'";
          User = "jwm";
          Group = "jwm";
        };
      };
    };
  };
  services.udisks2.enable = true;
}
