{ config, ... }: {

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
      PURE_PROMPT_SYMBOL='❯'
      PURE_GIT_PULL=1
      PURE_GIT_UNTRACKED_DIRTY=1

      autoload -Uz compinit
      autoload -U promptinit; promptinit

      if [[ "jwm" == "$(whoami)" ]];
      then
        eval $(ssh-agent -s) > /dev/null
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
