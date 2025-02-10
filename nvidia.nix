{ config, pkgs, lib, ... }: {

  hardware.graphics = {
    enable = lib.mkDefault true;
    enable32Bit = lib.mkDefault true;
    extraPackages = with pkgs; [ ];
    extraPackages32 = with pkgs.driversi686Linux; [ ];
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
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    powerManagement.finegrained = false;
    powerManagement.enable = true;
  };

  environment.etc."nvidia/nvidia-application-profiles-rc.d/50-limit-free-buffer-pool-in-wayland-compositors.json".source =
    ./resources/50-wayland-buffer-pool.json;
}
