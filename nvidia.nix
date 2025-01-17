{ config, pkgs, lib, ... }: {

  hardware.graphics = { enable = true; };

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
    package = config.boot.kernelPackages.nvidiaPackages.vulkan_beta;

    powerManagement.finegrained = false;
    powerManagement.enable = true;
  };
}
