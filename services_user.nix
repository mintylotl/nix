{ config, pkgs, ... }: {
  systemd = {
    user.enable = true;

    user.services = {
      sessionVariables = {
        PATH =
          "/run/current-system/sw/bin:/home/jwm/.emacs.d/bin:/home/jwm/.scripts/scripts/nginxHtml:$PATH";
      };

      nginx_html = {
        description = "Nginx HTML regenerator service";
        wantedBy = [ "default.target" ];

        serviceConfig = {
          ExecStart = "/home/jwm/.scripts/scripts/nginxHtml/nginx_html.sh";
          Restart = "always";
        };
      };
      emacs = {
        description = "Emacs Daemon Service";
        wantedBy = [ "default.target" ];

        serviceConfig = { ExecStart = "/home/jwm/.scripts/programs/emacs.sh"; };
      };
    };
  };
}
