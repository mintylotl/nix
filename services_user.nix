{ config, pkgs, ... }: {
  systemd = {
    user.services = {
      nginx_html = {
        description = "Nginx HTML regenerator service";
        wantedBy = [ "default.target" ];

        serviceConfig = {
          ExecStart =
            "${pkgs.python3} /home/jwm/.scripts/scripts/nginx_html.py";
          Restart = "always";
        };
      };
    };
  };
}
