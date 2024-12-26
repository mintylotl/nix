{ config, pkgs, ... }: {
  systemd = {
    services = {
      emacs = {
        wantedBy = [ "multi-user.target" ];
        description = "Emacs Daemon Service";

        serviceConfig = {
          ProtectHome = false;
          ReadWriteDirectories = [ "/home/jwm/.emacs.d" "/home/jwm/.doom.d" ];
          Environment = "HOME=/home/jwm";
          ExecStart =
            "${pkgs.bash}/bin/bash -c 'su jwm && cd && ${pkgs.emacs29-pgtk}/bin/emacs --fg-daemon'";
        };
        preStart = "${pkgs.bash}/bin/bash /system/scripts/mounts.sh 1";

        path = [ pkgs.util-linux pkgs.coreutils pkgs.shadow pkgs.su ];
      };
    };
  };
  services.udisks2.enable = true;
}
