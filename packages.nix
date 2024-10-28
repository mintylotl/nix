{ pkgs, config, lib, prism, ... }:
let 
  py = pkgs.python312Packages;
in {
  nixpkgs.overlays = [
    prism.overlays.default
    (final: prev: {
      glfw3-minecraft = prev.glfw3-minecraft.overrideAttrs {
        withMinecraftPatch = true;
      };
    })
  ];

  environment.systemPackages = with pkgs; [
    # New
    xdg-utils
    wayland
    gtk2 gtk3
    alsa-lib coreutils udev
    libselinux
    libdecor
    
    gst_all_1.gstreamer zenity
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-libav

    # Sound
    alsa-utils
    xcur2png
    pavucontrol
    audacity
    # Editors
    mpv
    emacs
    # Environment
    busybox
    htop
    libappindicator-gtk3
    neofetch
    speedcrunch
    openssl
    #Emulation
    bottles
    #RetroArch
    (retroarch.override { cores = with libretro; [ mame2016 ]; })
    lutris
    # EMACS
    fd
    ripgrep
    cmake
    clang
    jsbeautifier
    nixfmt-classic
    ispell
    gnuplot
    shfmt
    gnumake
    pipenv
    cmigemo
    stylelint
    shellcheck
    zig
    graphviz
    pandoc
    libtool
    rustup
    rust-analyzer
    pnpm
    html-tidy
    sbcl

    # QT
    qt6.full
    qt5.full
    qimgv
    qt6ct
    kwayland-integration
    catppuccin-cursors
    nwg-look

    # PrismLauncher Cracked
    prismlauncher
    # Python
    #System
    py.python
    py.pip
    #Misc
    py.yt-dlp
    #Emacs
    py.black
    py.isort
    py.pyflakes
    py.pytest
    py.setuptools
    py.nose2

    # System Utilities
    discord
    bitwarden-desktop
    git
    gcc
    cmake
    pkg-config
    btrfs-progs
    vulkan-tools
    rsync
    xdotool
    ecryptfs
    nodejs_22
    sqlite
    aria2
    pulseaudioFull
    yarn
    stow
    brightnessctl
    ffmpeg-full
    ark
    git-lfs

    # Thumbnailers
    ffmpegthumbnailer
    #JAVA
    openjdk22
    openjdk21
    openjdk17
    openjdk8

    # WINE
    dxvk
    dxvk_2
    vkd3d-proton
    gamescope
    # Programs
    wineWowPackages.stagingFull
    winetricks
    grim
    slurp
    hyprpaper
    wl-clipboard
    rofi
    cliphist
    firefox
    telegram-desktop
    hyprcursor
    rtaudio
    qbittorrent
    mako
    rose-pine-cursor

    # Icon_Themes
    breeze-gtk
    breeze-icons
    papirus-icon-theme
  ];

  programs.obs-studio.enable = true;
  programs.xfconf.enable = true;
  programs.dconf.enable = true;
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-volman 
      thunar-archive-plugin
      tumbler
      catfish
      garcon
      exo
    ];
  };
  programs.steam = {
    enable = true;
    protontricks.enable = true;
  };

  # Hyprland
  programs = {
    hyprland = { enable = true; };
    hyprlock.enable = true;
    xwayland.enable = true;
  };
  services.hypridle.enable = true;

  # Services
  services.vsftpd.enable = true;
  services.openssh.enable = true;
  services.tumbler.enable = true;

  services.jellyfin = {
    enable = true;
    dataDir = "/system/programs/jellyfin";
  };

  services.plex = {
    enable = true;
    package = pkgs.plex;
    accelerationDevices = [ ];
  };
  systemd.services.plex = {
    serviceConfig = {
      Environment = ''
        LD_LIBRARY_PATH="${pkgs.plex}/lib/plexmediaserver/lib"
      '';
    };
  };

  services.vaultwarden = {
    enable = true;
    package = pkgs.vaultwarden;
    environmentFile = "/system/programs/Vaultwarden/env.env";
    #config = "";
    dbBackend = "sqlite";
    config = {
      DATA_FOLDER = "/system/programs/Vaultwarden";
      ROCKET_ADRESS = "0.0.0.0";
      ROCKET_PORT = "37344";
    };
  };
  systemd.services.vaultwarden = {
    serviceConfig = {
      StateDirectory = lib.mkForce "/system/programs/Vaultwarden";
      ProtectSystem = lib.mkForce "off";
    };
  };
  
  xdg = {
    terminal-exec.enable = true;
    terminal-exec.settings = {
      default = [
        "alacritty.desktop"
      ];
    };
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
	xdg-desktop-portal-kde
      ];
      configPackages = with pkgs; [
        gnome-session
      ];
      xdgOpenUsePortal = true;
    };
    menus.enable = true;
    icons.enable = true;
    mime.enable = true;
  };

  # Fonts
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    fira-code
    fira-code-symbols
    proggyfonts
    font-awesome
  ];
}
