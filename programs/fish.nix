{ config, pkgs, lib, ... }:

{
  programs.fish = {
    interactiveShellInit = ''
      set fish_greeting ""
      alias ls="ls --color"
      alias nixosRebuild="sudo nixos-rebuild switch --flake /etc/nixos/intel#grape"
    '';
  };
}
