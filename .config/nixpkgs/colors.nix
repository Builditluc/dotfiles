let
  nix-colors = builtins.fetchTarball "https://github.com/misterio77/nix-colors/archive/main.tar.gz"; 
in
{
  colorscheme = (import "${nix-colors}/schemes").nord;
  colorscheme-name = "nord";
}
