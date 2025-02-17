{ nixpkgs, config, lib, pkgs, inputs, ... }:
let
  HOME = "/home/jwm";
  nvidia = config.boot.kernelPackages.nvidiaPackages.stable;
in {
  # nixOS
  imports = [
    ./hw-cfg.nix
    ./services.nix

    # Daemons
    ./daemons/nginx.nix
    ./daemons/vsftpd.nix
    #./daemons/aria2.nix

    ./nvidia.nix
    ./packages.nix
    ./programs/hyprland.nix
  ];

  nixpkgs.config.allowUnfree = true;

  nix = {
    package = pkgs.nix;
    extraOptions = "experimental-features = nix-command flakes";

    registry = {

      devShells = {
        to = {
          type = "path";
          path = "/etc/nixos/devShells";
        };
      };
      nixos.to = config.nix.registry.nixpkgs.to;
    };

    optimise = {
      automatic = false;
      dates = [ "06:00" ];
    };
    settings = {
      trusted-users = [ "jwm" ];
      trusted-substituters = [ "https://prismlauncher.cachix.org" ];

      substituters =
        [ "https://nix-community.cachix.org" "https://cache.nixos.org/" ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "prismlauncher.cachix.org-1:9/n/FGyABA2jLUVfY+DEp4hKds/rwO+SCOtbOkDzd+c="
      ];
    };
  };

  documentation = {
    dev.enable = true;
    man = {
      man-db.enable = false;
      mandoc.enable = true;
    };
  };

  # Use the systemd-boot EFI boot loader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    initrd.kernelModules = [
      # NVIDIA
      "nvidia"
      "nvidia-drm"
    ];
    kernelModules = [
      # AMDCPU
      "kvm-amd"

      # NVIDIA_GPU
      "nvidia_uvm"
      "nvidia_modeset"
      "nvidiafb"
    ];
    kernelParams = [
      "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
      "nvidia_drm.modeset=1"
      "nvidia_drm.fbdev=1"
    ];
    blacklistedKernelModules = [ "amdgpu" "i915" "nouveau" ];

    kernelPackages = pkgs.linuxPackages;
    extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];
  };

  # NETWORKING
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;
  networking.wireless.enable = false;
  networking.firewall = {
    enable = true;
    allowedTCPPortRanges = [{
      from = 0;
      to = 65000;
    }];
    allowedUDPPortRanges = [{
      from = 0;
      to = 65000;
    }];
  };

  networking.hostName = "cabbage";
  networking.hosts = {
    "127.0.0.1" = [ "ariaweb.srv" "jellyfin.srv" "fileserve.srv" ];
    "10.0.2.2" = [ "vault.tld" ];
  };
  networking.interfaces.enp42s0.macAddress = "2C:F0:5D:E5:E2:E1";
  networking.interfaces.enp42s0.useDHCP = true;

  networking.dhcpcd.enable = false;
  networking.nftables.enable = true;

  time.timeZone = "Africa/Johannesburg";

  security.sudo = {
    enable = true;
    extraRules = [{
      users = [ "jwm" ];
      commands = [
        {
          command = "${HOME}/.scripts/scripts/system/mounts.sh";
          options = [ "SETENV" "NOPASSWD" ];
        }
        {
          command = "${HOME}/.scripts/scripts/system/leds.sh";
          options = [ "SETENV" "NOPASSWD" ];
        }
        {
          command = "${HOME}/.scripts/programs/musicbee/prio.sh";
          options = [ "SETENV" "NOPASSWD" ];
        }
        {
          command = "${HOME}/.scripts/scripts/system/nixosgarbage.sh";
          options = [ "SETENV" "NOPASSWD" ];
        }
        {
          command = "${HOME}/.scripts/programs/musicbee/musicbee.sh";
          options = [ "SETENV" "NOPASSWD" ];
        }
        {
          command = "/run/current-system/sw/bin/nixos-rebuild";
          options = [ "SETENV" "NOPASSWD" ];
        }
      ];
    }];
  };

  # Locale
  i18n.defaultLocale = "en_US.UTF-8";

  # Groups
  users.groups = {
    freezer = { };
    jwm = { };
    gameboy = { };
    ftpsecure = { };
    certs = { };
    aria2 = { };
    pulse = { };
    nm-openconnect = { };
    nicely = { };
    gamers = { };
  };
  # Users
  users.users.jwm = {
    isNormalUser = true;
    home = "/home/jwm";
    group = "jwm";
    extraGroups = [ "wheel" "freezer" "realtime" "nicely" "audio" "gamers" ];
    linger = true;
    homeMode = "711";
  };
  users.users.gameboy = {
    isNormalUser = true;
    home = "/home/gameboy";
    homeMode = "771";
    group = "gamers";
    extraGroups = [ "wheel" "realtime" "nicely" "audio" "gamers" ];
  };
  users.users.ftpsecure = {
    isNormalUser = true;
    home = "/var/lib/jail";
    group = "ftpsecure";
    password = "123";
    createHome = false;
    homeMode = "755";
    extraGroups = [ "ftp" ];
  };
  users.users.nginx = { extraGroups = [ "certs" ]; };
  users.users.jellyfin = { extraGroups = [ "freezer" ]; };
  # Sound

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Services
  services.pipewire = {
    enable = true;
    wireplumber.enable = true;

    audio.enable = true;
    pulse.enable = true;
    jack.enable = true;

    alsa.enable = true;
    alsa.support32Bit = true;
  };

  # Securitay
  security.rtkit.enable = true;
  security.polkit = {
    enable = true;
    extraConfig = ''
      polkit.addRule(function (action, subject) {
        if ([
          "org.freedesktop.pipewire",
          "com.feralinteractive.gamemode"
        ].indexOf(action.id) !== -1 && subject.isInGroup("nicely")) {
          return polkit.Result.YES;
        }
      });
    '';
  };

  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTR{idVendor}=="04e8", MODE="0666", GROUP="plugdev"
  '';

  security.pam.loginLimits = [{
    domain = "@nicely";
    type = "-";
    item = "nice";
    value = -15;
  }];

  security.pki.certificateFiles = [ ./resources/certs/ca/rootCA.pem ];

  environment.variables = {
    NIX_CONF_DIR = "/etc/nixos";

    MESA_LOADER_DRIVER_OVERRIDE = "nvidia";
    LIBVA_DRIVER_NAME = "vdpau";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    NVD_BACKEND = "direct";

    VK_ICD_FILENAMES =
      "${nvidia}/share/vulkan/icd.d/nvidia_icd.x86_64.json:${nvidia.lib32}/share/vulkan/icd.d/nvidia_icd.i686.json";
    mbWINE = "${
        inputs.musicBee.legacyPackages.${pkgs.system}.wineWowPackages.stableFull.overrideAttrs {
          version = "9.0";
        }
      }/bin/wine";
  };

  system.stateVersion = "24.05";
}
