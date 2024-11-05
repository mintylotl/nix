{ config, pkgs, lib, ... }: {
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      libva-utils
      libva
      vulkan-loader
      vulkan-validation-layers
      nvidia-vaapi-driver
      opencl-headers

      xorg.libX11 xorg.libXext xorg.libXrandr xorg.libXi
    ];
    extraPackages32 = with pkgs;
      [
        #nvidia-vaapi-drive
        driversi686Linux.libva-vdpau-driver
      ];
  };

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
    powerManagement.finegrained = false;
  };

  environment.etc."nvidia/nvidia-application-profiles-rc.d/50-limit-free-buffer-pool-in-wayland-compositors" = {
    text = ''
    {
    "rules": [
      {
        "pattern": {
          "feature": "procname", "matches": "Hyprland" },
          "profile": "Limit Free Buffer Pool On Wayland Compositors"
      }
    ],
    "profiles": [
        {
            "name": "Limit Free Buffer Pool On Wayland Compositors",
            "settings": [
            {
              "key": "GLVidHeapReuseRatio",
              "value": 1
            }
          ]
        }
      ]
    }
    '';
  };
}
