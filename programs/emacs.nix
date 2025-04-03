{ config, lib, pkgs, ... }:
let
  epaks = pkgs.emacsPackages;
in
{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;

    extraPackages = epkgs:
      with pkgs; [
        epaks.vterm
        epaks.apheleia
        nixfmt
        epaks.ripgrep
        epaks.gnuplot
        epaks.shfmt
        epaks.pipenv
        epaks.pandoc

        fd
        cmake
        clang
        gnumake
        sbcl

        ispell
        stylelint
        jsbeautifier
        html-tidy

        cmigemo
        shellcheck
        graphviz

        libtool
        rustup
        rust-analyzer
        zig
        pnpm
      ];
  };

  services.emacs = {
    enable = true;
    client.enable = true;
    defaultEditor = true;

    startWithUserSession = true;
  };
  systemd.user.services.emacs = { Unit.After = [ "emacs-mounts.service" ]; };
}
