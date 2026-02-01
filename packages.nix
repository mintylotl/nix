{
  pkgs,
  pkgs_bleeding,
  pkgs_old,
  config,
  lib,
  inputs,
  prism,
  ...
}:
let
  #paksold = pkgs_old;
  py = pkgs.python312Packages;
  bleed = pkgs_bleeding;

in
{
  nixpkgs.overlays = [
    (final: prev: {
      prismlauncherCracked = prism.packages.${pkgs.system}.prismlauncher;
    })
  ];

  environment.systemPackages = with pkgs; [
    # General
    man-pages-posix
    vivid
    #bleed.ollama-cuda

    #protonvpn-cli
    openvpn
    #zrythm
    bespokesynth
    #bleed.lmstudio
    #conda
    #ryujinx
    #citron
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

    #vscode-fhs
    wineasio
    unzip
    #surge
    #sfizz
    rmpc
    poppler-utils
    pnpm
    p7zip
    nvme-cli
    ardour
    arch-install-scripts
    #veracrypt
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

    (aspellWithDicts (
      dicts: with dicts; [
        en
        en-computers
        en-science
      ]
    ))

    #cudaPackages.cudatoolkit
    xorg.xeyes
    xorg.xorgserver
    xorg.xrandr

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
    nixfmt-rfc-style
    shfmt
    shellcheck
    stylelint
    graphviz
    tk
    tree
    ocrmypdf
    php
    sl
    lsof
    hdparm
    gocryptfs
    fscryptctl

    #Python
    py.python
    py.black
    py.nose2
    py.pyflakes
    py.pytest
    py.isort
    py.tkinter

    bleed.jdk17

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

    # Project Zomboid
    dwarfs
    fuse-overlayfs
    libarchive
    hyprpolkitagent

    #OVMF
    #qemu_full
    umu-launcher

    cowsay
    kittysay
    pokemonsay
    smartmontools
    pkgs.blender
    keyutils
    compsize
    udisks
    timewarrior

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

    xcur2png
    pavucontrol
    #audacity
    bleed.mpv
    #busybox
    htop
    neofetch
    speedcrunch
    openssl

    (lutris.overrideAttrs ({
      extraPkgs = with pkgs; [
        vkd3d-proton
        dxvk_2
        gamescope
        mangohud
        vulkan-tools
        vulkan-loader
        gst_all_1.gstreamer
        gst_all_1.gst-vaapi
        gst_all_1.gst-plugins-base
        gst_all_1.gst-plugins-good
        gst_all_1.gst-plugins-ugly
        gst_all_1.gst-plugins-bad
        gst_all_1.gst-libav
      ];
    }))
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

    # (retroarch.withCores (
    #   cores: with cores; [
    #     mgba
    #     mame2003-plus
    #     mame2010
    #     snes9x
    #     nestopia
    #     ppsspp
    #     dolphin
    #     swanstation
    #     bsnes-mercury-performance
    #     bsnes-mercury
    #     fbalpha2012
    #     pcsx-rearmed
    #     genesis-plus-gx
    #     mame2000
    #     melonds
    #   ]
    # ))
    # retroarch-assets

    typescript
    # Python
    #System
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
    (ghc.withPackages (
      hp: with hp; [
        zlib
        cabal-install
      ]
    ))

    # Thumbnailers
    ffmpegthumbnailer
    #JAVA
    openjdk21
    openjdk17
    openjdk8

    # WINE
    wireshark-qt
    wireguard-tools
    duperemove
    # Programs
    #wineWowPackages.waylandFull
    #wineWowPackages.stableFull
    #wineWowPackages.unstableFull
    wineWowPackages.stableFull
    winetricks
    grim
    slurp
    hyprpaper
    wl-clipboard
    cliphist
    bleed.firefox-devedition
    telegram-desktop
    pkgs.qbittorrent
    mako
    bleed.zlib
    rose-pine-cursor
    aria2

    # Icon_Themes
    adwaita-icon-theme
    kdePackages.breeze-gtk
    kdePackages.breeze-icons
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
  programs = {
    ecryptfs.enable = false;
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        zlib
        glib
        nspr
        nss
        glibc
        glib
        nspr
        nss
        dbus
        atk
        at-spi2-core
        cups
        cairo
        gtk3
        pango
        xorg.libX11
        xorg.libXcomposite
        xorg.libXdamage
        xorg.libXext
        xorg.libXfixes
        xorg.libXrandr
        mesa
        expat
        xorg.libxcb
        libxkbcommon
        systemd
        alsa-lib
        gcc
        pkg-config
        libgbm
      ];
    };
  };
  programs.fuse = {
    userAllowOther = true;
    mountMax = 20;
  };

  # Services
  services.vsftpd.enable = true;
  services.openssh.enable = true;
  services.tumbler.enable = true;

  services.jellyfin = {
    enable = true;
    dataDir = "/system/programs/jellyfin";
  };

  services.vaultwarden = {
    enable = true;
    package = pkgs.vaultwarden;
    environmentFile = "/system/programs/Vaultwarden/env.env";
    #config = "";
    dbBackend = "sqlite";
    config = {
      DATA_FOLDER = "/system/programs/Vaultwarden";
      ROCKET_ADDRESS = "0.0.0.0";
      ROCKET_PORT = "37344";
    };
  };
  systemd.services.vaultwarden = {
    serviceConfig = {
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

  services.mongodb = {
    enable = false;
  };
  virtualisation.docker = {
    enable = false;
  };

  services.komga = {
    enable = true;
    stateDir = "/system/programs/komga";
    settings.server = {
      port = 37322;
    };
  };
  systemd.services.komga = {
    wants = [
      "mounts.service"
    ];
    after = [
      "mounts.service"
    ];
  };

  services.nix-serve = {
    enable = true;
    port = 29777;
    secretKeyFile = "/system/pass/cache-key.key";
  };

  services.aria2 = {
    enable = true;
    rpcSecretFile = "/system/programs/aria2/rpcsecret.txt";
    settings = {
      dir = "/home/jwm/Downloads/Aria";
      conf-path = "/system/programs/aria2/aria2.conf";
    };
  };
  systemd.services.aria2 = {
    serviceConfig = {
      User = "aria2";
      Group = "aria2";
    };
  };

  virtualisation.waydroid.enable = true;

  xdg = {
    terminal-exec.enable = true;
    terminal-exec.settings = {
      default = [ "alacritty.desktop" ];
    };
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal
        xdg-desktop-portal-gtk
      ];
      xdgOpenUsePortal = true;
    };
    icons.enable = true;
    menus.enable = true;
    mime.enable = true;
  };

  # Fonts
  fonts.packages = with bleed; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji

    proggyfonts
    font-awesome
    andika

    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.iosevka
    nerd-fonts.hack
  ];
}
