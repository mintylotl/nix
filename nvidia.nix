{ config, pkgs, lib, ... }: {
  services.xserver = {
    enable = true;
    videoDrivers = [
      "nvidia"
      "fbdev"
    ];
  };
  
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
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
