{ pkgs, pkgs_bleeding, pkgs_old, config, lib, inputs, prism, ... }:
let
  paksold = pkgs_old;
  py = pkgs.python312Packages;
  bleed = pkgs_bleeding;

in {
  nixpkgs.overlays = [
    (final: prev: {
      umu = inputs.umuProton.packages.${pkgs.system}.umu-launcher.override {
        withTruststore = true;
        withDeltaUpdates = true;
      };
      prismlauncherCracked = prism.packages.${pkgs.system}.prismlauncher;
      kdePackges = bleed.kdePackages;
    })
  ];

  environment.systemPackages = with pkgs; [
    # General
    man-pages-posix
    vivid
    bleed.ollama-cuda

    conda
    ryujinx
    citron
    zlib
    zip
    imhex
    gzip
    lz4
    gnutar
    cheat
    tldr
    most
    less

    vscode-fhs
    veracrypt
    hdparm
    libreoffice-qt6-fresh
    rpcs3
    vitetris
    joystickwake
    sdl-jstest
    jstest-gtk
    linuxConsoleTools
    hyprpicker
    ngrok
    cachix
    nicotine-plus
    filezilla
    mokuro
    jellyfin-mpv-shim
    bleed.osu-lazer-bin
    anki-bin
    anki-sync-server
    prisma-engines

    #Dicts
    hunspellDicts.ko_KR
    hunspellDicts.en_GB-ize
    hunspell

    (aspellWithDicts (dicts: with dicts; [ en en-computers en-science ]))

    #cudaPackages.cudatoolkit
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

    #Emacs
    cmigemo
    tidyp
    jsbeautifier
    html-tidy
    gnumake
    pkg-config
    cmake
    libtool
    libvterm
    editorconfig-checker
    editorconfig-core-c
    sbcl
    gdtoolkit_4
    libxml2
    gopls
    gomodifytags
    gotests
    gore
    haskell-language-server
    llvmPackages.clang-tools
    pandoc
    nixfmt
    shfmt
    shellcheck
    stylelint
    graphviz
    tk

    #Python
    py.black
    py.nose2
    py.pyflakes
    py.pytest
    py.isort
    py.tkinter

    pipenv
    poetry
    pyenv

    mumble
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
    bleed.godot_4
    xorg.xinit
    unrar
    kdePackages.ark
    strawberry-qt6

    # Project Zomboid
    dwarfs
    fuse-overlayfs
    libarchive
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
    bleed.audacity
    bleed.mpv
    #busybox
    htop
    neofetch
    speedcrunch
    bleed.openssl

    bleed.lutris
    protontricks

    fd
    ripgrep
    cmake
    clang
    gcc
    rustup
    bleed.rust-analyzer

    # QT
    qimgv
    kdePackages.qt6ct

    # PrismLauncher Cracked
    pkgs.prismlauncherCracked

    (retroarch.override {
      cores = with libretro; [
        mgba
        mame2003-plus
        mame2010
        snes9x
        nestopia
        ppsspp
        dolphin
        swanstation
        bsnes-mercury-performance
        bsnes-mercury
        fbalpha2012
        pcsx-rearmed
        genesis-plus-gx
        mame2000
      ];
    })
    retroarch-assets

    typescript
    # Python
    #System
    python3Full
    py.pip

    #Misc
    py.yt-dlp
    py.numpy

    # System Utilities
    home-manager
    bleed.discord
    bitwarden-desktop
    git
    #makemkv
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
    bleed.yt-dlp
    zig
    (ghc.withPackages (hp: with hp; [ zlib cabal-install ]))

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
    bleed.gamescope
    bleed.gamemode
    bleed.mangohud
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
    bleed.firefox-devedition-bin
    bleed.telegram-desktop
    pkgs.qbittorrent
    mako
    bleed.zlib
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
    plugins = with pkgs; [
      xfce.thunar-volman
      xfce.thunar-archive-plugin
      xfce.catfish
      xfce.garcon
      xfce.exo
      xfce.tumbler

      totem
      webp-pixbuf-loader
      mcomix
      f3d
      gnome-epub-thumbnailer
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
  #services.cachix-agent.enable = true;

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

  services.murmur = {
    enable = true;
    port = 37374;
    registerName = "Mumbone";
    bonjour = true;
    users = 3;
    welcometext = "Welcome to the Abyss";
  };

  services.bookstack = {
    enable = false;
    dataDir = "/system/programs/bookstack";
    appKeyFile = "/system/programs/bookstack/appkey";
  };

  services.navidrome = {
    enable = true;
    settings.Port = 37311;
    settings = {
      MusicFolder = "/Drives/WD1TB/Archive/Artists";
      DataFolder = "/system/programs/navidrome";
      CacheFolder = "/system/programs/navidrome/cache";
    };
  };

  services.komga = {
    enable = true;
    stateDir = "/system/programs/komga";
    port = 37322;
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
  programs = {
    ecryptfs.enable = true;
    nix-ld = {
      enable = true;
      libraries = with pkgs; [ zlib gcc ];
    };
  };

  programs.fuse = {
    userAllowOther = true;
    mountMax = 100;
  };

  # Fonts
  fonts.packages = with bleed; [
    noto-fonts
    noto-fonts-extra
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji

    proggyfonts
    font-awesome

    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.iosevka
    nerd-fonts.hack
  ];
}
