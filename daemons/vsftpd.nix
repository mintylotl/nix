{ config, lib, ... }:

{
  security.pam.services.vsftpd.unixAuth = true;
  services.vsftpd = {
    enable = true;
    anonymousUser = false;
    localUsers = true;
    writeEnable = true;
    chrootlocalUser = false;
    allowWriteableChroot = true;
    extraConfig = ''
      local_umask=000
      file_open_mode=0666
      data_connection_timeout=120
      idle_session_timeout=600
      pasv_enable=yes
      pasv_min_port=40000
      pasv_max_port=40100
      pam_service_name=vsftpd
      seccomp_sandbox=NO
      check_shell=NO
    '';
  };
}
