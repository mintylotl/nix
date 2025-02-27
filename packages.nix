{ pkgs, pkgs_old, config, lib, inputs, prism, ... }:
let
  paksold = pkgs_old;
  py = pkgs.python312Packages;

in {
  nixpkgs.overlays = [
    (final: prev: {
      umu = inputs.umuProton.packages.${pkgs.system}.umu-launcher.override {
        withTruststore = true;
        withDeltaUpdates = true;
      };
      prismlauncherCracked = prism.packages.${pkgs.system}.prismlauncher;
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

    cachix
    nicotine-plus
    filezilla
    mokuro
    gammastep
    geoclue2
    jellyfin-mpv-shim
    osu-lazer-bin
    anki-bin
    anki-sync-server

    cudaPackages.cudatoolkit
    xorg.xeyes
    xorg.xorgserver
    xorg.xrandr

    ventoy-bin

    stuntman
    heimdall
    gvfs
    simple-mtpfs
    libmtp
    android-tools

    shadow
    wget
    coreutils
    psmisc
    ntfs3g
    libxkbcommon
    alsa-plugins
    alsa-firmware
    alsa-lib
    alsa-tools
    alsa-utils
    godot_4
    ecryptfs
    xorg.xinit
    unrar
    kdePackages.ark
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
    smartmontools
    pkgs.blender
    keyutils
    compsize
    pkgs.gtk2
    pkgs.gtk3
    udisks
    timewarrior
    nvtopPackages.nvidia

    # GTK Libs
    zenity
    gst_all_1.gstreamer
    gst_all_1.gst-vaapi
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-libav

    vulkan-loader
    vulkan-headers
    vulkan-validation-layers

    xcur2png
    pavucontrol
    audacity
    mpv
    #busybox
    htop
    neofetch
    speedcrunch
    openssl

    lutris
    protontricks

    fd
    ripgrep
    cmake
    clang
    gnumake
    gcc
    rustup
    rust-analyzer

    # QT
    qimgv
    kdePackages.qt6ct

    # PrismLauncher Cracked
    pkgs.prismlauncherCracked

    # Python
    #System
    python3Full
    py.pip

    #Misc
    py.yt-dlp
    py.numpy

    #Emacs
    py.black
    py.isort
    py.pyflakes
    py.nose2

    # System Utilities
    discord
    bitwarden-desktop
    git
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
    wireshark-qt
    wireguard-tools
    duperemove
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
    pkgs.firefox-devedition-bin
    telegram-desktop
    pkgs.qbittorrent
    mako
    rose-pine-cursor
    paksold.aria2

    # Icon_Themes
    adwaita-icon-theme
    breeze-gtk
    breeze-icons
    papirus-icon-theme
  ];

  programs.obs-studio = {
    enable = true;
    package = pkgs.obs-studio;
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
  services.cachix-agent.enable = true;

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
