{ config, pkgs, lib, inputs, ... }: {
  programs = {
    hyprland = {
      enable = true;
      package = inputs.Hyprland.packages.${pkgs.system}.hyprland;
      portalPackage =
        inputs.Hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
    };
    hyprlock.enable = true;
    xwayland.enable = true;
  };
  services.hypridle.enable = true;
}
