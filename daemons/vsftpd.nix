{ config, lib, ... }:

{ 
  services.vsftpd = {
    anonymousUser = false;
    localUsers = true;
    #localRoot = "/var/lib/jail";
    writeEnable = true;
    chrootlocalUser = true;
    allowWriteableChroot = true;
    extraConfig = ''
      local_umask=022
      file_open_mode=0777
    '';
  };
}
