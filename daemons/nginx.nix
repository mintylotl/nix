{
  config,
  lib,
  pkgs,
  ...
}:
let
  httpsPortDefault = "443";
  httpsFileserver = "1111";
  httpFileserver = "2121";
  httpsJellyfin = "9998";
  httpJellyfin = "9999";
  httpsAnki = "37356";
  httpAnki = "37355";
  httpsKomga = "9997";
  httpKomga = "37322";

  sslCert = "/system/certs/ssl/ssl.crt";
  sslCertSecret = "/system/certs/ssl/ssl.key";
  proxy = "proxy_pass http://127.0.0.1";

  # Locations
  locDefault = ''
    root /system/programs/nginx;
    index index.html index.htm;
  '';

in
{
  systemd.services.nginx = {
    serviceConfig = {
      ProtectSystem = lib.mkForce "off";
    };
  };
  services.nginx = {
    enable = true;
    config = ''
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
              client_max_body_size 500M;
              charset utf-8;
              gzip on;

              ssl_certificate ${sslCert};
              ssl_certificate_key ${sslCertSecret};

              proxy_set_header Host $host;
              proxy_set_header X-Real-IP $remote_addr;
              proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
              proxy_set_header X-Forwarded-Proto $scheme;

      server {
          listen 37346 ssl;
          server_name ariaweb.srv jellyfin.srv fileserve.srv vault.tld;

          #ssl_certificate     ${sslCert};
          #ssl_certificate_key ${sslCertSecret};

          location / {
              proxy_pass http://11.0.0.2:37344;

              proxy_set_header Host $host;
              proxy_set_header X-Real-IP $remote_addr;
              proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
              proxy_set_header X-Forwarded-Proto https;
          }
      }
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
              server {
                client_max_body_size 2G;
                proxy_read_timeout 180;
                proxy_send_timeout 180;

                listen ${httpsKomga} ssl;

                location ~* \.(?:ico|css|js|jpe?g|png|gif|webp|svg|woff2?)$ {
                  expires 30d;
                  access_log off;
                  add_header Cache-Control "public";
                  proxy_pass http://127.0.0.1:${httpKomga};
                }
                location / {
                  proxy_pass http://127.0.0.1:${httpKomga};
                }
              }
            }
    '';
  };
}
