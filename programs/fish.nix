{ config, pkgs, lib, ... }:

{
  programs.fish = {
    interactiveShellInit = ''
      set fish_greeting ""
      
      alias ls="ls --color"
      
      #NIXOS
      alias nixosRebuild="sudo nixos-rebuild switch --flake /etc/nixos#banana"
      alias garb="sudo /system/scripts/nixosgarbage.sh"
    '';
  };
}
