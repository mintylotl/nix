{ config, lib, pkgs, ... }:
let
  httpsPortDefault = "443";
  httpsFileserver = "1111";
  httpFileserver = "2121";
  #httpsVaultwarden = "444";
  #httpVaultwarden = 34777;
  #httpNotifVaultwarden = 34778;
  httpsJellyfin = "9998";
  httpJellyfin = "9999";
  httpPlex = "32400";
  httpsAnki = "37356";
  httpAnki = "37355";

  sslCert = "/system/certs/ssl/ssl.crt";
  sslCertSecret = "/system/certs/ssl/ssl.key";
  proxy = "proxy_pass http://127.0.0.1";

  # Locations
  locDefault = ''
    root /system/programs/nginx;
    index index.html index.htm;
  '';

in {
  services.nginx.enable = true;
  systemd.services.nginx = {
    serviceConfig = { ProtectSystem = lib.mkForce "off"; };
  };
  services.nginx.config = ''
    #Nginx Config
    worker_processes 4;
    #pid /run/nginx.pid;
    #log /run/nginx.log;
    events {
        worker_connections 2048;
    }

    http {
        include ${pkgs.nginx}/conf/mime.types;
        default_type application/octet-stream;
        charset utf-8;
        gzip on;
        ssl_certificate ${sslCert};
        ssl_certificate_key ${sslCertSecret};
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;

        server {
          listen ${httpsFileserver} ssl;
          location / {
            ${locDefault}
          }
        }
        server {
          listen ${httpFileserver};
          location / {
            ${locDefault}
          }
        }
        server {
          listen ${httpsAnki} ssl;
            location / {
              ${proxy}:${httpAnki};
            }
            location /msync {
              ${proxy}:${httpAnki};
            }
        }
    }
  '';
}
