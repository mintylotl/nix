{ config, pkgs, lib, ... }: {

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-sdk
      intel-media-driver
    ];
  };

  services.xserver = { enable = false; };

  services.displayManager.sddm = {
    enable = lib.mkForce true;
    wayland.enable = true;
  };

  services.desktopManager.plasma6.enable = true;

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
    MESA_DRIVER_LOADER_OVERRIDE = "iris";
  };
}
