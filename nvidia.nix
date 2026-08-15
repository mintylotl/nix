{
  config,
  pkgs,
  lib,
  ...
}:
{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = [ pkgs.nvidia-vaapi-driver ];
    #extraPackages32 = [ pkgs.driversi686Linux.libva-vdpau-driver ];
  };

  services.xserver = {
    #enable = false;
    videoDrivers = [ "nvidia" ];
  };

  services.displayManager.sddm = {
    enable = lib.mkForce false;
  };

  services.desktopManager.plasma6.enable = true;

  hardware.nvidia = {
    modesetting.enable = true;

    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.production;

    powerManagement.finegrained = false;
    powerManagement.enable = true;
  };

  environment.etc."nvidia/nvidia-application-profiles-rc.d/50-limit-free-buffer-pool-in-wayland-compositors.json".source =
    ./resources/50-wayland-buffer-pool.json;
}
