{ config, pkgs, ... }: {
  systemd = {
    user.services = {
      nginx_html = {
        description = "Nginx HTML regenerator service";
        wantedBy = [ "default.target" ];

        serviceConfig = {
          ExecStart = "/home/jwm/.scripts/scripts/nginxHtml/nginx_html.sh";
          Restart = "always";
        };
      };
      emacsC = {
        description = "Emacs Daemon Service";
        wantedBy = [ "default.target" ];

        serviceConfig = {
          ExecStart = "/home/jwm/.scripts/programs/emacs.sh";
          Restart = "on-failure";
        };
      };
    };
  };
}
