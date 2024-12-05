{ config, pkgs, lib, ... }: {
  services.xserver = {
    enable = true;
    videoDrivers = [
      "nvidia"
      "fbdev"
    ];
  };

  hardware.nvidia = {
    modesetting.enable = true;

    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;

    powerManagement.finegrained = false;
    powerManagement.enable = true;
  };
}
