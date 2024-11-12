{ config, pkgs, lib, inputs, ... }:
{
  programs = {
    hyprland = { 
      enable = true;
      package = pkgs.hyprland;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
    };
    hyprlock.enable = true;
    xwayland.enable = true;
  };
  services.hypridle.enable = true;

  programs.uwsm = {
    enable = true;
    waylandCompositors.hyprland = {
      binPath = "/run/current-system/sw/bin/Hyprland";
      comment = "Hyprland session managed by uwsm";
      prettyName = "Hyprland";
    };
  };
}
