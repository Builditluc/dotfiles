{ config, pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    shellAliases = {
      ls = "exa";
      c = "cargo";
      vf = "vifm";
      v = "nvim";
      lgit = "lazygit";
      config = "git --git-dir=$HOME/dotfiles --work-tree=$HOME";
    };
    initExtraFirst = ''
      auto-ls-git-onefetch () { if (ls -laF | grep .git/ >> /dev/null); then onefetch; fi; }
    '';
    initExtra = ''
      source /etc/static/zshrc
      path+=("$HOME/.local/bin")
      path+=("$HOME/.cargo/bin")
      path+=("$HOME/Developing/bin")
      export PATH
    '';
    localVariables = { 
      AUTO_LS_COMMANDS = "git-onefetch"; 
    };
    zplug = {
      enable = true;
      plugins = [
        { name = "desyncr/auto-ls"; }
        { name = "zsh-users/zsh-autosuggestions"; }
      ];
    };
  };  
}
