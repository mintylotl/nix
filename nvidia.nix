{ config, pkgs, lib, ... }: {
  services.xserver = {
    enable = false;
    videoDrivers = [ "nvidia" "fbdev" ];
  };

  services.displayManager.sddm = {
    enable = lib.mkForce false;
    wayland.enable = false;
  };

  services.desktopManager.plasma6.enable = false;

  hardware.nvidia = {
    modesetting.enable = true;

    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;

    powerManagement.finegrained = false;
    powerManagement.enable = true;
  };
}
