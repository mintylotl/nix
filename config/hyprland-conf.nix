{
  config,
  pkgs,
  lib,
  ...
}:
{
  wayland.windowManager.hyprland = {
    enable = true;

    # Home Manager's Lua-mode config entrypoint imports ~/.config/hypr/config.lua.
    configType = "lua";

    systemd = {
      enable = true;
      variables = [ "--all" ];
    };

    settings = { };
    extraConfig = ''
      require("config")
    '';
  };

  home.file = {
    # Main Lua config migrated from the old Nix settings.
    ".config/hypr/config.lua" = {
      source = ../dots/config/hypr/config.lua;
    };
    # Scripts (union of the old config and the updated reference file).
    ".config/hypr/gamemode.sh" = {
      source = ../dots/config/hypr/gamemode.sh;
    };
    ".config/hypr/startup.sh" = {
      source = ../dots/config/hypr/startup.sh;
    };
    ".config/hypr/sink.sh" = {
      source = ../dots/config/hypr/sink.sh;
    };
    ".config/hypr/shuffle_bg.sh" = {
      source = ../dots/config/hypr/shuffle_bg.sh;
    };
    ".config/hypr/xdp.sh" = {
      source = ../dots/config/hypr/xdp.sh;
    };

    # Other Hyprland configs.
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
