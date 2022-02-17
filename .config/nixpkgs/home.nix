{ config, pkgs, ... }:
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "builditluc";
  home.homeDirectory = "/Users/builditluc";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.11";

  home.packages = [
    pkgs.gnupg
    pkgs.bat
    pkgs.gh
    pkgs.wget
    pkgs.yt-dlp
    pkgs.ffmpeg
    pkgs.update-nix-fetchgit
    pkgs.docker
    pkgs.docker-compose
    pkgs.lazygit
    pkgs.nms
    pkgs.mpv
    pkgs.vifm
    pkgs.exa
    pkgs.pre-commit
    pkgs.gh
    pkgs.wiki-tui

    pkgs.neofetch
    pkgs.onefetch

    # pkgs.rustup
    pkgs.rust-analyzer
    pkgs.pyright
    pkgs.nixfmt
    pkgs.rnix-lsp
    pkgs.ripgrep

    pkgs.python39Packages.python-lsp-server
    pkgs.python39Packages.python-lsp-black
  ];
  
  xdg.configFile."nix/nix.conf".text = ''
    experimental-features = nix-command flakes
    '';
}
