{
  config,
  lib,
  pkgs,
  ...
}:

{
  services.mako = {
    enable = true;
    settings = {
      font = "JetBrainsMono Nerd Font 10";
      width = 300;
      height = 150;
      padding = "10";
      margin = "10";
      borderSize = 2;
      borderRadius = 5;
      backgroundColor = "#1e1e2e";
      textColor = "#cdd6f4";
      borderColor = "#89b4fa";
      defaultTimeout = 5000;
    };
  };
}
