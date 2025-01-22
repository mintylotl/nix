{ config, pkgs, lib, ... }: {

  hardware.graphics = {
    enable = lib.mkDefault false;
    enable32Bit = lib.mkDefault false;
    extraPackages = with pkgs; [
      vulkan-loader
      vulkan-validation-layers
      vulkan-headers

      libva-vdpau-driver
    ];
    extraPackages32 = with pkgs.driversi686Linux; [ libva-vdpau-driver ];
  };

  services.xserver = {
    enable = false;
    videoDrivers = [ "nvidia" ];
  };

  services.displayManager.sddm = {
    enable = lib.mkForce false;
    wayland.enable = false;
  };

  services.desktopManager.plasma6.enable = true;

  hardware.nvidia = {
    modesetting.enable = true;

    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;

    powerManagement.finegrained = false;
    powerManagement.enable = true;
  };
}
