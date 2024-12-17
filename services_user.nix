{ config, pkgs, ... }: {
  systemd = {
    user.enable = true;
    user.startServices = "sd-switch";

    user.sessionVariables = {
      PATH =
        "/run/current-system/sw/bin:/home/jwm/.emacs.d/bin:/home/jwm/.scripts/scripts/nginxHtml:$PATH";
    };

    user.services = {
      nginx_html = {
        Unit = { Description = "Nginx HTML regenerator service"; };
        Service = {
          ExecStart = "/home/jwm/.scripts/scripts/nginxHtml/nginx_html.sh";
          Restart = "always";
        };
        Install = { WantedBy = [ "default.target" ]; };
      };
    };
  };
}
