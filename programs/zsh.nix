{ config, ... }:
{

  home.file.".zmodules" = {
    enable = true;
    text = ''
      zinit light zsh-users/zsh-autosuggestions
      zinit light zsh-users/zsh-syntax-highlighting

      #zinit ice depth=1
      #zinit light romkatv/powerlevel10k
      zinit light sindresorhus/pure

      zinit ice fpath"src"
      zinit light zsh-users/zsh-completions
      zi ice as"program" make'!' atclone'./direnv hook zsh > zhook.zsh' atpull'%atclone' src"zhook.zsh"
      zi light direnv/direnv
    '';
  };

  programs.zsh = {
    enable = true;
    completionInit = "";
    initContent = ''
      ZINIT_HOME="''${XDG_DATA_HOME:-''${HOME}/.local/share}/zinit/zinit.git"
      SCRIPTS_DIR="$HOME"/.scripts

      [ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
      [ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"

      alias ls="ls --color"
      alias e="exit"
      alias vd="veracrypt -t -d"
      alias vc="veracrypt -t -c"
      alias vm="veracrypt -t"

      alias mounts="sudo $SCRIPTS_DIR/system/mounts.sh"
      alias nixosFlake="sudo nixos-rebuild switch --flake /etc/nixos#cabbage"
      alias nixosFlakeF="sudo nixos-rebuild switch --flake /etc/nixos#cabbage --fast --offline"

      alias tday="timew day from 6:00 - 20:00"
      alias lday="timew day from now - 20:00"
      alias resume="timew continue && timew join @2 @1"
      alias fetch="fetcher.sh"
      alias emacsc="emacsclient -c -a emacs -s "$HOME"/.doom.d/emacflurry/mcflurry"
      alias garb="sudo $SCRIPTS_DIR/system/nixosgarbage.sh 1"
      alias garbBige="sudo $SCRIPTS_DIR/system/nixosgarbage.sh 0"
      alias blender3="$HOME"/.local/state/nix/profiles/blender3/bin/blender
      alias todosC="git commit -a -m "todos@$(date +'%Y-%m-%dT%H:%M:%S')""

        # --gocryptfs
        alias crypts="sudo -E /etc/nixos/dots/scripts/system/usb_crypt.sh"
        alias cryptsU="sudo -E /etc/nixos/dots/scripts/system/usb_crypt.sh 3"
        alias org="sudo -E /etc/nixos/dots/scripts/system/usb_crypt.sh org"
        alias orgu="umount -l ''${HOME}/.orgnotes"

        # --wireguard
        alias wgVlanU="sudo wg-quick up ~/.wireguard/vlan.conf"
        alias wgVlanD="sudo wg-quick down ~/.wireguard/vlan.conf"
        alias wgClientU="sudo wg-quick up ~/.wireguard/client2.conf"
        alias wgClientD="sudo wg-quick down ~/.wireguard/client2.conf"

      PATH="/home/jwm/.cargo/bin:/home/jwm/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin:$SCRIPTS_DIR/scripts:$HOME/.local/bin:$HOME/.emacs.d/bin:$PATH"
      PURE_PROMPT_SYMBOL='❯'
      PURE_GIT_PULL=1
      PURE_GIT_UNTRACKED_DIRTY=1

      autoload -Uz compinit
      autoload -U promptinit; promptinit

      if [[ "jwm" == "$(whoami)" ]];
      then
        eval $(ssh-agent -s) >/dev/null
        ssh-add -q ~/".ssh/github_ssh.key"
      fi

      source "''${ZINIT_HOME}/zinit.zsh"
      source "''${HOME}/.zmodules"

      LS_COLORS=$(vivid generate tokyonight-storm)

      compinit
      zstyle ':completion:*' completer _complete _ignored _files
      zstyle ':completion:*' file-sort name
      zstyle ':completion:*' list-colors 'tty=1'
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
      zstyle ':completion:*' special-dirs true
      zstyle ':completion:*' menu select=1
      zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
      zstyle ':completion:*' list-dirs-first true
      zstyle ':completion:*' rehash true
    '';
  };
}
