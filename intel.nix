{ config, pkgs, lib, ... }: {

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [ "intel-media-sdk" ];
  };

  services.xserver = { enable = false; };

  services.displayManager.sddm = {
    enable = lib.mkForce true;
    wayland.enable = true;
  };

  services.desktopManager.plasma6.enable = true;
}
