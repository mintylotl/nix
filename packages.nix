{ pkgs_unst, pkgs, nixpkgs_unstable, config, lib, inputs, ... }:
let
  pkgs = pkgs_unst;
  py = pkgs.python312Packages;
in {
  nixpkgs_unstable.overlays = [
    inputs.prism.overlays.default
    (final: prev: {
      umu = inputs.umuProton.packages.${pkgs.system}.umu.override {
        version = "${inputs.umuProton.shortRev}";
      };
    })
  ];

  environment.systemPackages = with pkgs; [
    # General
    man-pages-posix

    zip
    imhex
    gzip
    lz4
    gnutar
    cheat
    tldr
    most
    less

    xorg.xeyes
    xorg.xorgserver
    xorg.xeyes
    xorg.xrandr

    ventoy-bin

    heimdall
    sunshine
    gvfs
    simple-mtpfs
    libmtp
    android-tools

    direnv
    ntfs3g
    libxkbcommon
    alsa-plugins
    alsa-firmware
    alsa-lib
    xorg.xauth
    godot_4
    ecryptfs
    xorg.xinit
    megasync
    soulseekqt
    unrar
    wlr-randr
    alsa-tools
    ark
    strawberry-qt6

    # Project Zomboid
    dwarfs
    fuse-overlayfs
    libarchive
    gnutar
    hyprpolkitagent

    #OVMF
    #qemu_full
    umu

    cowsay
    kittysay
    pokemonsay
    vulkan-loader
    smartmontools
    vulkan-headers
    blender
    keyutils
    compsize
    gtk2
    gtk3
    alsa-lib
    udisks
    timewarrior
    nvtopPackages.nvidia

    # GTK Libs
    zenity
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-libav

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

    lutris
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
    qimgv
    kdePackages.qt6ct
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
    gnumake
    makemkv
    pkg-config
    btrfs-progs
    vulkan-tools
    rsync
    xdotool
    nodejs_22
    yarn
    stow
    brightnessctl
    ffmpeg-full

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
    #wineWowPackages.stableFull
    #wineWowPackages.unstableFull
    wineWowPackages.stagingFull
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
    aria2

    # Icon_Themes
    adwaita-icon-theme
    breeze-gtk
    breeze-icons
    papirus-icon-theme
  ];

  programs.obs-studio = {
    enable = true;
    plugins = [ pkgs.obs-studio-plugins.wlrobs ];
  };
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
    gamescopeSession.enable = false;
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
      extraPortals = with pkgs; [ xdg-desktop-portal xdg-desktop-portal-gtk ];
      xdgOpenUsePortal = true;
    };
    icons.enable = true;
    menus.enable = true;
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
