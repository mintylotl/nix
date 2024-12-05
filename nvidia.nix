{ config, pkgs, lib, ... }: {
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = [
      libva
      libva-vdpau-driver
      libva-utils
    ];
  };

  services.xserver = {
    videoDrivers = [ "nvidia" "fbdev" ];
    enable = true;
  };

  hardware.nvidia = {
    modesetting.enable = true;

    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;

    powerManagement.finegrained = false;
    powerManagement.enable = true;
  };

  environment.etc."nvidia/nvidia-application-profiles-rc.d/50-limit-free-buffer-pool-in-wayland-compositors" =
    {
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
