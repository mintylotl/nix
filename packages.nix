{ pkgs, config, lib, pkgs-lsg, inputs, ... }:
let py = pkgs.python312Packages;
in {
  nixpkgs.overlays = [
    inputs.prism.overlays.default
    (final: prev: {
      umu = inputs.umuProton.packages.${pkgs.system}.umu.override {
        version = "${inputs.umuProton.shortRev}";
      };
      cudatoolkit = prev.cudatoolkit.overrideAttrs { enableCuda = true; };
      blender = pkgs-lsg.blender;
    })
  ];

  environment.systemPackages = with pkgs; [
    alsa-tools
    xorg.xinit
    strawberry-qt6
    #baobab
    # Project Zomboid
    dwarfs
    fuse-overlayfs
    libarchive
    # New
    #cudatoolkit
    gnutar
    bottles
    hyprpolkitagent

    #OVMF
    #qemu_full
    umu

    cowsay
    kittysay
    pokemonsay
    egl-wayland
    vulkan-loader
    smartmontools
    vulkan-headers
    wayland-pipewire-idle-inhibit
    blender
    keyutils
    aria2
    compsize
    gtk2
    gtk3
    alsa-lib
    udisks
    timewarrior
    nvtopPackages.nvidia

    # GTK Libs
    zenity
    #gst_all_1.gstreamer
    #gst_all_1.gst-plugins-base
    #gst_all_1.gst-plugins-good
    #gst_all_1.gst-plugins-ugly
    #gst_all_1.gst-plugins-bad
    #gst_all_1.gst-libav

    alsa-utils
    xcur2png
    pavucontrol
    audacity
    mpv
    busybox
    htop
    neofetch
    speedcrunch
    openssl

    appindicator-sharp
    libindicator
    libindicator-gtk2
    libindicator-gtk3
    libayatana-common
    libappindicator-gtk3
    libayatana-indicator
    libayatana-indicator-gtk3
    libayatana-appindicator
    libayatana-appindicator-gtk3

    #Emulation
    #RetroArch
    (retroarch.override { cores = with libretro; [ mame2016 ]; })

    (lutris.override { extraPkgs = pkgs: [ wlr-randr ]; })

    # EMACS
    protontricks
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
    qt6Packages.qtstyleplugin-kvantum
    qimgv
    qt6ct
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
    ecryptfs
    discord
    bitwarden-desktop
    git
    gcc
    gnumake
    makemkv
    openvdb
    pkg-config
    btrfs-progs
    vulkan-tools
    rsync
    xdotool
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
    openjdk23
    openjdk21
    openjdk17
    openjdk8

    # WINE
    dxvk
    dxvk_2
    vkd3d-proton
    gamescope
    gamemode
    mangohud
    # Programs
    #wineWowPackages.waylandFull
    wineWowPackages.stableFull
    #wineWowPackages.unstableFull
    #wineWowPackages.stagingFull
    winetricks
    grim
    slurp
    hyprpaper
    wl-clipboard
    cliphist
    firefox
    telegram-desktop
    qbittorrent
    mako
    rose-pine-cursor
    zenity

    # Icon_Themes
    adwaita-icon-theme
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
    gamescopeSession.enable = true;
  };
  programs.gamemode = {
    enable = true;
    enableRenice = true;
  };

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
    terminal-exec.settings = { default = [ "alacritty.desktop" ]; };
    portal = {
      enable = true;
      extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
      xdgOpenUsePortal = true;
    };
    menus.enable = true;
    icons.enable = true;
    mime.enable = true;
  };
  programs.ecryptfs.enable = true;

  qt.style = "kvantum";

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
