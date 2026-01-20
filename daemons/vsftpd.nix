{ config, lib, ... }:

{
  services.vsftpd = {
    anonymousUser = false;
    localUsers = true;
    #localRoot = "/var/lib/jail";
    writeEnable = true;
    chrootlocalUser = false;
    allowWriteableChroot = true;
    extraConfig = ''
      local_umask=022
      file_open_mode=0775
    '';
  };
}
