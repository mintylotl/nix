{ config, lib, pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs29-pgtk;

    extraPackages = epkgs:
      with epkgs; [
        vterm
        fd-dired
        ripgrep
        cpputils-cmake
        clang-format
        nixfmt
        helm-ispell
        tree-sitter-ispell
        gnuplot
        gnuplot-mode
        shfmt
        flymake-shellcheck
        zig-mode
        graphviz-dot-mode
        pandoc
        pandoc-mode
        rust-mode
        rustic
        flycheck-rust
        pnpm-mode

        pkgs.libtool
        pkgs.sbcl
        pkgs.rust-analyzer
        pkgs.clang
      ];
  };

  services.emacs = {
    enable = true;
    client.enable = true;
    defaultEditor = true;

    startWithUserSession = true;
  };
  systemd.user.services.emacs = {
    Unit.after = [ "emacs.service" ];
  };
}
