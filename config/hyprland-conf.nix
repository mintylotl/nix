{ config, pkgs, lib, ... }: {
  wayland.windowManager.hyprland = {
    enable = true;

    extraConfig = ''
                  monitor = HDMI-A-1, 1280x1024@60.00, 0x0, 1
                  workspace = HDMI-A-1, 1

                  # --Nvidia
                      env = __GLX_VENDOR_LIBRARY_NAME, nvidia
                      env = LIBVA_DRIVER_NAME, nvidia
                      env = GBM_BACKEND, nvidia-drm
                      env = NVD_BACKEND, direct

      env = SDL_VIDEODRIVER, wayland
      env = GDK_BACKEND, wayland, x11


                  # --Themes
                      # --QT
                      env = QT_QPA_PLATFORM, wayland
                      env = GTK_USE_PORTAL, 1

                  # --XDG / DBUS
                      env = XDG_CURRENT_DESKTOP, Hyprland
                      env = XDG_SESSION_TYPE, wayland

            	  exec-once = systemctl --user start hyprpolkitagent
            	  exec-once = systemctl --user start xdg-desktop-portal-hyprland

                  # --IME / IMF
                      env = XMODIFIERS, @im=fcitx

                  # Hyprland
                      $HOME = "/home/jwm"
            	  $scripts = "$HOME"/.scripts/scripts
            	  $emacsDir = "$HOME"/.emacs.d

                  # --Envar
                      env = XCURSOR_SIZE, 24
                      env = XCURSOR_THEME, "BreezeX-RosePineDawn-Linux"
                      env = HYPRCURSOR_SIZE, 24
                      env = HYPRCURSOR_THEME, "rosepine-cursor"

                      # --Scripts
                          exec-once = "$HOME"/.config/hypr/sink.sh
            	      exec-once = sudo -E "$scripts"/system/leds.sh&
            	      exec-once = sudo -E "$scripts"/system/mounts.sh

                      # --Programs
                          exec-once = hyprpaper
                          # --Lutris
                              env = LUTRIS_SKIP_INIT, 1


                  exec = dconf write /org/gnome/desktop/interface/cursor-theme "'BreezeX-RosePineDawn-Linux'"
                  exec = dconf write /org/gnome/desktop/interface/gtk-theme "'Breeze-Dark'"

                  cursor {
                      no_hardware_cursors = true
                  }
                  input {
                      kb_layout = us
                      #kb_variant =
                      #kb_model =
                      #kb_options =
                      #kb_rules =

                      touchpad {
                          natural_scroll = false
                      }

                      sensitivity = 0.5
                      follow_mouse = 1
                      numlock_by_default = true
                  }
                  general {
                      gaps_in = 3
                      gaps_out = 5
                      border_size = 3

                      col.active_border = rgba(008b8baa)
                      col.inactive_border = rgba(595959aa)

                      layout = master
            	  allow_tearing = true
                  }
                  decoration {
                      rounding = 3

                      blur {
                          enabled = true
                          size = 2
                          passes = 1
                      }
                  }
                  animations {
                      enabled = true
                      bezier = myBezier, 0.05, 0.9, 0.1, 1.05

                      animation = windows, 1, 7, myBezier
                      animation = windowsOut, 1, 7, default, popin 80%
                      animation = border, 1, 10, default
                      animation = borderangle, 1, 8, default
                      animation = fade, 1, 7, default
                      animation = workspaces, 1, 6, default
                  }
                  dwindle {
                      pseudotile = true
                      preserve_split = true
                  }
                  master {
                      #new_is_master = false
                      orientation = top
                      new_on_top = false
                  }
                  gestures {
                      workspace_swipe = false
                  }
                  misc {
                      vfr = false
                  }
                  render {
                      explicit_sync = 0
                  }

                  #WindowRules
                  windowrule = workspace 2 silent, ^(steam)$
                  windowrule = workspace 2 silent, ^(lutris)$
                  windowrule = workspace 8 silent, ^(org.qbittorrent.qBittorrent)$
                  windowrule = workspace 1 silent, ^(firefox)$

                  # WindowruleV2s
                  # --XDG
                  windowrulev2 = float, class:xdg-desktop-portal-gtk
                  windowrulev2 = size 880 680, class:xdg-desktop-portal-gtk
                  windowrulev2 = center 1, class:xdg-desktop-portal-gtk
                  # --Alacritty
                  windowrulev2 = float, class:Alacritty
                  windowrulev2 = size 850 790, class:Alacritty
                  # --QimgV
                  windowrulev2 = float, class:qimgv
                  windowrulev2 = size 800 800, class:qimgv
                  windowrulev2 = center 1, class:qimgv
                  # --Lutris
                  windowrulev2 = float, class:lutris, title:^(?!Lutris).*$
                  windowrulev2 = center 1, class:lutris, title:^(?!Lutris).*$
                  windowrulev2 = size 950 700, class:lutris, title:^(?!Lutris).*$
                  # --polkit
                  windowrulev2 = float, class:^(org.kde.polkit-kde-authentication-agent-1)$
                  windowrulev2 = center 1, class:^(org.kde.polkit-kde-authentication-agent-1)$
                  # --Steam
                  windowrulev2 = float, class:(steam), title:(Friends List)
                  windowrulev2 = size 940 740, class:(steam), title:(Friends List)
                  windowrulev2 = center 1, class:^(steam)$
                  windowrulev2 = float, class:^(steam)$, title:^(Steam Settings)$
                  windowrulev2 = center 1, class:^(steam)$, title:^(Steam Settings)$
                  # --Irfanview
                  windowrulev2 = maximize, class:^(i_view64\.exe)$, title:^(IrfanView)$
                  # --Firefox
                  #windowrulev2 = float
                  # --VSS Code
                  windowrulev2 = float, class:^(code-oss)$
                  windowrulev2 = center 1, class:^(code-oss)$
                  windowrulev2 = size 1052 705, class:^(code-oss)$
                  # --Ark
                  windowrulev2 = float, class:^(org.kde.ark)$
                  windowrulev2 = center 1, class:^(org.kde.ark)$, title:^(Ark)$
                  windowrulev2 = size 925 635, class:^(org.kde.ark)$, title:^(Ark)$
                  # --Compressing...
                  windowrulev2 = size 350 160, class:^(org.kde.ark)$, title:^(Compressing.*)$
                  windowrulev2 = move 14 850, class:^(org.kde.ark)$, title:^(Compressing.*)$
                  # --Kitty
                  windowrulev2 = float, class:^(kitty)$
                  windowrulev2 = size 615 168, class:^(kitty)$
                  windowrulev2 = move 651 842, class:^(kitty)$
                  # --Emacs
                  windowrulev2 = float, class:^(Emacs)$
                  windowrulev2 = center 1, class:^(Emacs)$
                  windowrulev2 = size 950 850, class:^(Emacs)$
                  # --PavuControl
                  windowrulev2 = float, class:^(org.pulseaudio.pavucontrol)$
                  windowrulev2 = center 1, class:^(org.pulseaudio.pavucontrol)$
                  windowrulev2 = size 1094 345, class:^(org.pulseaudio.pavucontrol)$
                  # --qBittorrent
                  #windowrulev2 = float, class:^(qBittorrent)$, title:^(?!.*qBittorrent).*$
                  windowrulev2 = float, class:^(org.qbittorrent.qBittorrent)$, title:^(?!.*qBittorrent).*$
                  # --winetricks
                  windowrulev2 = float, class:^(zenity)$
                  windowrulev2 = center 1, class:^(zenity)$
                  # --speedcrunch
                  windowrulev2 = float, class:^(org.speedcrunch.)$
                  windowrulev2 = center 1, class:^(org.speedcrunch.)$
                  # --thunar
                  windowrulev2 = float, class:^(thunar)$, title:^(File Operation Progress)$
                  windowrulev2 = size 500 160, class:^(thunar)$, title:^(File Operation Progress)$
                  windowrulev2 = move 14 850, class:^(thunar)$, title:^(File Operation Progress)$
                  windowrulev2 = float, class:^(thunar)$, title:^(Confirm to replace files)$
                  windowrulev2 = center 1, class:^(thunar)$, title:^(Confirm to replace files)$
                  windowrulev2 = float, class:^(thunar)$, title:^(Rename.*)$
                  windowrulev2 = size 470 137, class:^(thunar)$, title:^(Rename.*)$
                  windowrulev2 = move 405 443, class:^(thunar)$, title:^(Rename.*)$
                  windowrulev2 = center 1, class:^(thunar)$, title:^(Rename.*)$
                  # --mpv
                  windowrulev2 = float, class:^(mpv)
                  windowrulev2 = size 1000 800, class:^(mpv)
                  windowrulev2 = center 1, class:^(mpv)
                  # --discord
                  windowrulev2 = float, class:^(Bitwarden)$
                  windowrulev2 = center 1, class:^(Bitwarden)$
                  # --puddletag
                  windowrulev2 = float, class:^(python3)$, title:^(puddletag)$
                  windowrulev2 = size 1250 970, class:^(python3)$, title:^(puddletag)$
                  windowrulev2 = center 1, class:^(python3)$, title:^(puddletag)$
                  # --doomemacs
                  windowrulev2 = float, class:^(emacs)$, title:^(.*Doom Emacs)$
                  windowrulev2 = size 1000 800, class:^(emacs)$, title:^(.*Doom Emacs)$
                  windowrulev2 = center 1, class:^(emacs)$, title:^(.*Doom Emacs)$
                  # --QOwnNotes
                  windowrulev2 = float, class:^(PBE.*)$
                  windowrulev2 = size 1000 700, class:^(PBE.*)$, title:default
                  windowrulev2 = center 1, class:^(PBE.*)$
                  # --XnViewMP
                  windowrulev2 = float, class:^(com.xnview.XnView)$, title:(.*XnView MP)
                  windowrulev2 = maximize, class:^(com.xnview.XnView)$, title:(.*XnView MP)
                  # --Strawberry
                  windowrulev2 = float, class:^(org.strawberrymusicplayer.strawberry)$, title:^(.*Strawberry Music Player)$
                  windowrulev2 = maximize, class:^(org.strawberrymusicplayer.strawberry)$, title:^(.*Strawberry Music Player)$
                  # --Telegram
                  windowrulev2 = float, class:^(org.telegram.desktop)$
                  windowrulev2 = size 1000 700, class:^(org.telegram.desktop)$, title:^(Telegram)$
                  windowrulev2 = center 1, class:^(org.telegram.desktop)$
                  # --Neovim
                  windowrulev2 = float, class:^(Gvim)$
                  windowrulev2 = center 1, class:^(Gvim)$
                  # --MusicBee
                  windowrulev2 = fullscreen, class:^(musicbee.exe)$, title:^(.*MusicBee)$
                  windowrulev2 = float, class:^(musicbee.exe)$, title:^()$
                  # --Mp3Tag
                  windowrulev2 = maximize, class:^(mp3tag.exe)$, title:^(Mp3tag v3.26  -  ).*$


                  #Binds
                  $HOME = "/home/jwm"
                  $mainMod = SUPER
                  $shortcut_dir = "$HOME/.scripts/programs/musicbee/shortcuts"

                  # --ScreenShotting
                  bind = , Print, exec, grim -l 4 -g "0,0 1280x1024"
                  bind = $mainMod, Print, exec, grim -l 8 -g "$(slurp)"
                  # --Editors
                  bind = $mainMod, O, exec, alacritty -e nvim ./
                  bind = $mainMod, I, exec, alacritty -e nvim ./newfilevim
                  # --Clipboard
                  exec-once = wl-paste --type text --watch cliphist store
                  bind = $mainMod, A, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy
                  # --Hypr Utilities
                  bind = $mainMod, N, layoutmsg, orientationtop
                  bind = $mainMod, K, exec, hyprctl kill
                  bind = $mainMod, Q, exec, hyprctl dispatch pin
                  bind = $mainMod, W, togglefloating
                  bind = $mainMod, B, fullscreen
                  bind = $mainMod, F, fullscreen, 1
                  bind = $mainMod, D, exec, hyprctl dispatch centerwindow
                  bind = $mainMod, M, exec, loginctl terminate-user ""
                  bind = $mainMod, C, killactive
                  bind = $mainMod, T, exec, cliphist wipe
                  bind = $mainMod, SPACE, exec, rofi -show drun
                  bind = $mainMod, V, layoutmsg, swapwithmaster
                  bind = $mainMod, L, exec, pidof hyprlock || hyprlock
                  bind = $mainMod, U, exec, ~/.config/hypr/gamemode.sh
                  bind = $mainMod CTRL, down, exec, bash -c 'archwiki-offline'
                  # --Audio
                  bind = , F7, exec, pactl set-sink-volume alsa-headphones -5%
                  bind = , F8, exec, pactl set-sink-volume alsa-headphones +5%
                  # --Programs
                  bind = $mainMod, P, exec, /home/jwm/.scripts/programs/musicbee/launcher.sh

                  bind = $mainMod, G, exec, MOZ_ENABLE_WAYLAND=1 firefox
                  bind = $mainMod, RETURN, exec, alacritty
                  bind = $mainMod, S, exec, speedcrunch
                  bind = $mainMod, E, exec, GDK_BACKEND="wayland" GTK_ICON_THEME="Papirus-Dark" thunar
                  bind = $mainMod, Z, exec, emacsclient -c
                  # --MusicBee
                      bind = , End, exec, $shortcut_dir/play_pause.sh
                      bind = , Pause, exec, $shortcut_dir/shuffle.sh
                      bind = , Delete, exec, $shortcut_dir/open_close.sh
                      bind = , Home, exec, $shortcut_dir/next.sh
                      bind = , Next, exec, $shortcut_dir/stop_after_current.sh
                      bind = , Scroll_Lock, exec, $shortcut_dir/previous.sh

                  # --Other
                  bind = $mainMod, X, exec, alacritty -e nvim /home/jwm/.config/hypr/hyprland.conf
                  bind = $mainMod, R, movetoworkspacesilent, 7
                  #bind = $mainMod, R, workspaceopt, allfloat

                  # --Window Control
                  bindm = $mainMod, mouse:272, movewindow
                  bindm = $mainMod, mouse:273, resizewindow
                      # --Focus
                      bind = $mainMod SHIFT, left, layoutmsg, orientationleft
                      bind = $mainMod SHIFT, right, layoutmsg, orientationright
                      bind = $mainMod, up, movefocus, u
                      bind = $mainMod, down, movefocus, d
                      bind = $mainMod, left, movefocus, l
                      bind = $mainMod, right, movefocus, r
                      # --Workspaces
                      bind = $mainMod, 1, workspace, 1
                      bind = $mainMod, 2, workspace, 2
                      bind = $mainMod, 3, workspace, 3
                      bind = $mainMod, 4, workspace, 4
                      bind = $mainMod, 5, workspace, 5
                      bind = $mainMod, 6, workspace, 6
                      bind = $mainMod, 7, workspace, 7
                      bind = $mainMod, 8, workspace, 8
                      bind = $mainMod, 9, workspace, 9
                      bind = $mainMod, 0, workspace, 10
                      # --Window to workspace
                      bind = $mainMod, 87, movetoworkspacesilent, 1
                      bind = $mainMod, 88, movetoworkspacesilent, 2
                      bind = $mainMod, 89, movetoworkspacesilent, 3
                      bind = $mainMod, 83, movetoworkspacesilent, 4
                      bind = $mainMod, 84, movetoworkspacesilent, 5
                      bind = $mainMod, 85, movetoworkspacesilent, 6
                      bind = $mainMod, 79, movetoworkspacesilent, 7
                      bind = $mainMod, 80, movetoworkspacesilent, 8
                      bind = $mainMod, 81, movetoworkspacesilent, 9
                      bind = $mainMod, 90, movetoworkspacesilent, 10
                      # --To workspace with active window
                      bind = $mainMod SHIFT, 87, movetoworkspace, 1
                      bind = $mainMod SHIFT, 88, movetoworkspace, 2
                      bind = $mainMod SHIFT, 89, movetoworkspace, 3
                      bind = $mainMod SHIFT, 83, movetoworkspace, 4
                      bind = $mainMod SHIFT, 84, movetoworkspace, 5
                      bind = $mainMod SHIFT, 85, movetoworkspace, 6
                      bind = $mainMod SHIFT, 79, movetoworkspace, 7
                      bind = $mainMod SHIFT, 80, movetoworkspace, 8
                      bind = $mainMod SHIFT, 81, movetoworkspace, 9
                      bind = $mainMod SHIFT, 90, movetoworkspace, 10
                      # --Cycle workspaces with ScrollWheel
                      bind = $mainMod, mouse_down, workspace, e+1
                      bind = $mainMod, mouse_up, workspace, e-1
    '';
    systemd = {
      enable = true;
      variables = [ "--all" ];
    };
  };
  home.file = {
    # SCRIPTS
    ".config/hypr/gamemode.sh" = { source = ../dots/config/hypr/gamemode.sh; };
    ".config/hypr/startup.sh" = { source = ../dots/config/hypr/startup.sh; };
    ".config/hypr/sink.sh" = { source = ../dots/config/hypr/sink.sh; };
    ".config/hypr/xdp.sh" = { source = ../dots/config/hypr/xdp.sh; };

    # CONFIG
    ".config/hypr/hypridle.conf" = {
      source = ../dots/config/hypr/hypridle.conf;
    };
    ".config/hypr/hyprpaper.conf" = {
      source = ../dots/config/hypr/hyprpaper.conf;
    };
    ".config/hypr/hyprlock.conf" = {
      source = ../dots/config/hypr/hyprlock.conf;
    };
  };
}
