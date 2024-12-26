{ config, pkgs, ... }: {
  systemd = {
    services = {
      emacs = {
        wantedBy = [ "multi-user.target" ];
        Description = "Emacs Daemon Service";

        serviceConfig = {
          ExecStart = ''echo "${pkgs.emacs-pgtk-with-packages}"'';
        };
      };
    };
  };
  services.udisks2.enable = true;
}
