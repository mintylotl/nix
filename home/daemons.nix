{
  config,
  lib,
  pkgs,
  ...
}:

{
  services.mako = {
    enable = true;
    font = "JetBrainsMono Nerd Font 10";
    width = 300;
    height = 150;
    padding = "10";
    margin = "10";
    borderSize = 2;
    borderRadius = 5;
    backgroundColor = "#1e1e2e"; # Example: Catppuccin Mocha Base
    textColor = "#cdd6f4"; # Example: Catppuccin Mocha Text
    borderColor = "#89b4fa"; # Example: Catppuccin Mocha Blue
    defaultTimeout = 5000; # Milliseconds
  };
}
