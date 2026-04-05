{ config, pkgs, ... }:
{
  systemd = {
    services = {
      mc = {
        description = "A service for running the Minecraft Server (1.21.11)";
        after = [ "network-online.target" ];
        requires = [ "network-online.target" ];
        wantedBy = [ "multi-user.target" ];
        path = [ pkgs.wireguard-tools ];

        serviceConfig = {
          Type = "forking";
          User = "root";
          Group = "root";
          WorkingDirectory = "/system/programs/minecraft/thegamev2";
          ProtectSystem = "false";
          ProtectHome = "false";
          PrivateTmp = "false";

          ExecStart = "${pkgs.tmux}/bin/tmux -S /run/mc.socket new-session -d -s mc_sess '${pkgs.bash}/bin/bash /system/programs/minecraft/thegamev2/run.sh ${pkgs.openjdk21}'";
          ExecStop = "${pkgs.tmux}/bin/tmux -S /run/mc.socket send-keys -t mc_sess stop ENTER";
          Restart = "on-failure";
          KillMode = "none";
        };
      };
      alice = {
        description = "A service for running the Alice Bot";
        after = [ "network-online.target" ];
        requires = [ "network-online.target" ];
        wantedBy = [ "multi-user.target" ];
        environment = {
          TELOXIDE_TOKEN = "8530595599:AAEZKbP5ir67zybUTiQRnUV4yR6IsFXBgG0";
        };

        serviceConfig = {
          WorkingDirectory = "/system/programs/alice";
          ExecStart = "/run/current-system/sw/bin/bash -c './alice_bot'";
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
        before = [ "emacs.service" ];
        path = [
          pkgs.util-linux
          pkgs.coreutils
        ];

        serviceConfig = {
          ExecStart = "${pkgs.bash}/bin/bash /system/scripts/mounts.sh 1";
          ProtectSystem = false;
          ProtectHome = false;
          WorkingDirectory = "/home/jwm";
        };
      };
    };
  };
  services.udisks2.enable = true;
}
