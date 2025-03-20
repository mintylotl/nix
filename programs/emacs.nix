{ config, lib, pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;

    extraPackages = epkgs:
      with pkgs; [
        epkgs.vterm
        epkgs.apheleia
        epkgs.nixfmt
        epkgs.ripgrep
        epkgs.gnuplot
        epkgs.shfmt
        epkgs.pipenv
        epkgs.pandoc

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
