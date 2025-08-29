{
  config,
  pkgs,
  lib,
  ...
}:
{
  wayland.windowManager.hyprland = {
    enable = true;

    systemd = {
      enable = true;
      variables = [ "--all" ];
    };

    settings = {
      monitor = "HDMI-A-1, 1280x1024@60.00, 0x0, 1";
      workspace = "HDMI-A-1, 1";

      # Nvidia
      #env = __GLX_VENDOR_LIBRARY_NAME, nvidia
      #env = LIBVA_DRIVER_NAME, nvidia
      #env = GBM_BACKEND, nvidia-drm
      #env = NVD_BACKEND, direct

      env = [
        # THEMING
        "GDK_BACKEND, wayland, x11"
        "QT_QPA_PLATFORM, wayland"

        # Cursors
        "XCURSOR_SIZE, 24"
        "XCURSOR_THEME, \"BreezeX-RosePineDawn-Linux\""
        "HYPRCURSOR_SIZE, 24"
        "HYPRCURSOR_THEME, \"rosepine-cursor\""

        # XDG / DBUS
        "XDG_CURRENT_DESKTOP, Hyprland"
        "XDG_SESSION_DESKTOP, Hyprland"
        "XDG_SESSION_TYPE, wayland"
      ];

      exec-once = [
        # Startup / Env / Dbus / XDG
        "sleep 10s && systemctl --user start hyprpolkitagent"
        "systemctl --user start xdg-desktop-portal-hyprland"
        "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"

        # Clipboard
        "wl-paste --type text --watch cliphist store"

        # Scripts
        "$HOME/.config/hypr/sink.sh"
        "sudo -E $scripts/system/leds.sh&"
        # Programs
        "hyprpaper"
        "fcitx5 -d"
      ];

      exec = [
        "dconf write /org/gnome/desktop/interface/cursor-theme \"'BreezeX-RosePineDawn-Linux'\""
        "dconf write /org/gnome/desktop/interface/gtk-theme \"'Breeze-Dark'\""
      ];

      # Hyprland Variables
      "$HOME" = "/home/jwm";
      "$scripts" = "$HOME/.scripts";
      "$emacsDir" = "$HOME/.emacs.d";

      # --Lutris
      #env = LUTRIS_SKIP_INIT, 1

      cursor = {
        no_hardware_cursors = true;
      };
      input = {
        kb_layout = "us";
        #kb_variant =
        #kb_model =
        #kb_options =
        #kb_rules =

        touchpad = {
          natural_scroll = false;
        };

        sensitivity = 0.5;
        follow_mouse = 1;
        numlock_by_default = true;
      };
      general = {
        gaps_in = 3;
        gaps_out = 5;
        border_size = 3;

        #col.active_border = rgba(1803E799)
        "col.active_border" = "rgba(240FB480)";
        "col.inactive_border" = "rgba(595959aa)";

        layout = "master";
        allow_tearing = true;
      };

      decoration = {
        rounding = 3;

        blur = {
          enabled = true;
          size = 2;
          passes = 1;
        };
      };

      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };
      master = {
        #new_is_master = false
        orientation = "top";
        new_on_top = false;
      };
      gestures = {
        workspace_swipe = false;
      };

      render = {
        explicit_sync = 0;
      };
      misc = {
        vfr = false;
        enable_anr_dialog = false;
      };

      windowrule = [
        # Simple Placement
        "workspace 2 silent, class:^steam$"
        "workspace 2 silent, class:^lutris$"
        "workspace 8 silent, class:^org\\.qbittorrent\\.qBittorrent$"

        "suppressevent maximize, class:.*"

        # Windowrules
        #Doom Emacs
        "float, class:emacs"
        "size 1169 750, class:emacs"

        # Alacritty
        "float, class:Alacritty"
        "size 1000 300, class:Alacritty"
      ];

      # Binds
      "$mainMod" = "SUPER";
      "$shortcut_dir" = "$HOME/.programs/musicbee/shortcuts";

      bind = [
        # ScreenShotting
        ", Print, exec, grim -l 4 -g \"0,0 1280x1024\""
        "$mainMod, Print, exec, grim -l 8 -g \"$(slurp)\""

        # Editors
        "$mainMod, O, exec, alacritty -e nvim ./"
        "$mainMod, I, exec, alacritty -e nvim ./newfilevim"
        "$mainMod, A, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
        "$mainMod, Z, exec, emacsclient -c -s \"$HOME/.doom.d/emacflurry/mcflurry\""

        # Hypr Utilities
        "$mainMod, N, layoutmsg, orientationtop"
        "$mainMod, K, exec, hyprctl kill"
        "$mainMod, Q, exec, hyprctl dispatch pin"
        "$mainMod, W, togglefloating"
        "$mainMod, B, fullscreen"
        "$mainMod, F, fullscreen, 1"
        "$mainMod, D, exec, hyprctl dispatch centerwindow"
        "$mainMod, C, killactive"
        "$mainMod, V, layoutmsg, swapwithmaster"
        "$mainMod, L, exec, pidof hyprlock && hyprlock || hyprlock"
        #"$mainMod, U, exec, ~/.config/hypr/gamemode.sh"
        #bind = $mainMod, R, workspaceopt, allfloat

        # Misc
        "$mainMod, M, exec, loginctl terminate-user \"\""
        "$mainMod CTRL, down, exec, bash -c 'archwiki-offline'"
        "$mainMod, T, exec, cliphist wipe"
        "$mainMod, SPACE, exec, rofi -show drun -width 65 -lines 15"

        # Audio
        ", F7, exec, wpctl set-volume 33 5%-"
        ", F8, exec, wpctl set-volume 33 5%+"

        # Programs
        # -MusicBee
        "$mainMod, P, exec, $shortcut_dir/../launcher.sh"
        # -Misc
        "$mainMod, G, exec, firefox-devedition"
        "$mainMod, RETURN, exec, alacritty"
        "$mainMod, S, exec, speedcrunch"
        "$mainMod, E, exec, GDK_BACKEND=\"wayland\" GTK_ICON_THEME=\"Papirus-Dark\" thunar"

        # Shortcuts
        # -MusicBee
        ", End, exec, $shortcut_dir/play_pause.sh"
        ", Pause, exec, $shortcut_dir/shuffle.sh"
        ", Delete, exec, $shortcut_dir/close_kill.sh"
        ", Home, exec, $shortcut_dir/next.sh"
        ", Next, exec, $shortcut_dir/stop_after_current.sh"
        ", Scroll_Lock, exec, $shortcut_dir/previous.sh"

        # Other
        "$mainMod, X, exec, alacritty -e nvim /home/jwm/.config/hypr/hyprland.conf"
        "$mainMod, R, movetoworkspacesilent, 7"

        # Window Control
        # -Focus
        "$mainMod SHIFT, left, layoutmsg, orientationleft"
        "$mainMod SHIFT, right, layoutmsg, orientationright"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        # -Workspaces
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"
        # -Window to workspace
        "$mainMod, 87, movetoworkspacesilent, 1"
        "$mainMod, 88, movetoworkspacesilent, 2"
        "$mainMod, 89, movetoworkspacesilent, 3"
        "$mainMod, 83, movetoworkspacesilent, 4"
        "$mainMod, 84, movetoworkspacesilent, 5"
        "$mainMod, 85, movetoworkspacesilent, 6"
        "$mainMod, 79, movetoworkspacesilent, 7"
        "$mainMod, 80, movetoworkspacesilent, 8"
        "$mainMod, 81, movetoworkspacesilent, 9"
        "$mainMod, 90, movetoworkspacesilent, 10"
        # -To workspace with active window
        "$mainMod SHIFT, 87, movetoworkspace, 1"
        "$mainMod SHIFT, 88, movetoworkspace, 2"
        "$mainMod SHIFT, 89, movetoworkspace, 3"
        "$mainMod SHIFT, 83, movetoworkspace, 4"
        "$mainMod SHIFT, 84, movetoworkspace, 5"
        "$mainMod SHIFT, 85, movetoworkspace, 6"
        "$mainMod SHIFT, 79, movetoworkspace, 7"
        "$mainMod SHIFT, 80, movetoworkspace, 8"
        "$mainMod SHIFT, 81, movetoworkspace, 9"
        "$mainMod SHIFT, 90, movetoworkspace, 10"
        # -Cycle workspaces with ScrollWheel
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
      ];
      bindm = [
        # Window Control
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
  };

  home.file = {
    # SCRIPTS
    ".config/hypr/gamemode.sh" = {
      source = ../dots/config/hypr/gamemode.sh;
    };
    ".config/hypr/startup.sh" = {
      source = ../dots/config/hypr/startup.sh;
    };
    ".config/hypr/sink.sh" = {
      source = ../dots/config/hypr/sink.sh;
    };
    ".config/hypr/xdp.sh" = {
      source = ../dots/config/hypr/xdp.sh;
    };

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
