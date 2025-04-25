{ config, ... }: {

  home.file.".zmodules" = {
    enable = true;
    text = ''
      zinit light zsh-users/zsh-autosuggestions
      zinit light zdharma-continuum/fast-syntax-highlighting
      zinit light zdharma-continuum/history-search-multi-word

      zinit ice depth=1
      zinit light romkatv/powerlevel10k

      zinit ice fpath"src"
      zinit light zsh-users/zsh-completions

      zi ice as"program" make'!' atclone'./direnv hook zsh > zhook.zsh' atpull'%atclone' src"zhook.zsh"
      zi light direnv/direnv
    '';
  };

  programs.zsh = {
    enable = true;
    completionInit = "";
    initExtra = ''
      # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
      # Initialization code that may require console input (password prompts, [y/n]
      # confirmations, etc.) must go above this block; everything else may go below.

      ZINIT_HOME="''${XDG_DATA_HOME:-''${HOME}/.local/share}/zinit/zinit.git"

      [ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
      [ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"

      alias ls="ls --color"
      alias e="exit"
      alias vd="veracrypt -t -d"
      alias vc="veracrypt -t -c"
      alias vm="veracrypt -t"

      alias mounts="sudo $HOME/.scripts/scripts/system/mounts.sh"
      alias nixosFlake="sudo nixos-rebuild switch --flake /etc/nixos#cabbage"
      alias nixosFlakeF="sudo nixos-rebuild switch --flake /etc/nixos#cabbage --fast --offline"

      alias mounts="sudo $HOME/.scripts/scripts/system/mounts.sh"
      alias fetch="fetcher.sh"
      alias emacsc="emacsclient -c -a emacs -s /home/jwm/.doom.d/emacflurry/mcflurry"
      alias garb="sudo $HOME/.scripts/scripts/system/nixosgarbage.sh 1"
      alias garbBige="sudo $HOME/.scripts/scripts/system/nixosgarbage.sh 0"
      alias blender3="~/.local/state/nix/profiles/blender3/bin/blender"

        # --ecryptfs
        alias mount.crypt="mount.ecryptfs_private"
        alias umount.crypt="umount.ecryptfs_private"
        alias ikey="insert.sh"

        # --wireguard
        alias wgVlanU="sudo wg-quick up ~/.wireguard/vlan.conf"
        alias wgVlanD="sudo wg-quick down ~/.wireguard/vlan.conf"
        alias wgClientU="sudo wg-quick up ~/.wireguard/client2.conf"
        alias wgClientD="sudo wg-quick down ~/.wireguard/client2.conf"

      PATH="/home/jwm/.cargo/bin:/home/jwm/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin:$HOME/.scripts/scripts:$HOME/.local/bin:$HOME/.emacs.d/bin:$PATH"
      source "''${ZINIT_HOME}/zinit.zsh"
      source "''${HOME}/.zmodules"

      source "''${HOME}/.p10k.zsh"

      POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
         source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi
    '';
  };
}
