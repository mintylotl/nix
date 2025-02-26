{ config, pkgs, lib, Hyprland, inputs, ... }: {
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
}
