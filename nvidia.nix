{ config, pkgs, lib, ... }: {
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  services.xserver = { videoDrivers = [ "nvidia" "fbdev" ]; };
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
          {
            "pattern": {
              "feature": "procname", "matches": "alacritty" },
              "profile": "Limit Free Buffer Pool On Wayland Compositors"
          }
          {
            "pattern": {
              "feature": "procname", "matches": "Xwayland" },
              "profile": "Limit Free Buffer Pool On Wayland Compositors"
          }
          {
            "pattern": {
              "feature": "procname", "matches": "firefox" },
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
