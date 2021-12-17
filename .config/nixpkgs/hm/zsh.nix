{ pkgs, config, ... }:
let
  colorscheme = (import ../colors.nix).colorscheme;
in
{
  programs.zsh = {
    enable = true;
    shellAliases = {
      ls = "exa";
      c = "cargo";
      vf = "vifm";
      v = "nvim";
      lgit = "lazygit";
      update =
        "update-nix-fetchgit $HOME/.config/nixpkgs/home.nix && nix-channel --update && darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/configuration.nix";
      nixconf = "nvim $HOME/.config/nixpkgs/home.nix";
      darconf = "nvim $HOME/.config/nixpkgs/configuration.nix";
      config = "git --git-dir=$HOME/dotfiles --work-tree=$HOME";
    };
    initExtraFirst = ''
      auto-ls-git-onefetch () { if (ls -laF | grep .git/ >> /dev/null); then onefetch; fi; }
    '';
    initExtra = ''
      source /etc/static/zshrc

      path+=("/Users/builditluc/.local/bin")
      path+=("/Users/builditluc/.cargo/bin")
      path+=("/Users/builditluc/OneDrive/Developing/bin")

      export PATH
    '';
    localVariables = { 
      AUTO_LS_COMMANDS = "git-onefetch"; 
      NIXPKGS_ALLOW_UNFREE = 1;
    };
    zplug = {
      enable = true;
      plugins = [
        { name = "MichaelAquilina/zsh-auto-notify"; }
        { name = "desyncr/auto-ls"; }
        { name = "zsh-users/zsh-autosuggestions"; }
      ];
    };
  };
}
