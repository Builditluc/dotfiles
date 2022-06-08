{
  description = "Builditluc's system config";

  inputs = {
    nixpkgs.url = "github:/nixos/nixpkgs/nixos-unstable";
    utils.url = "github:gytis-ivaskevicius/flake-utils-plus";

    darwin.url = "github:lnl7/nix-darwin/master";
    home-manager.url = "github:nix-community/home-manager";
    nur.url = "github:nix-community/nur";

    nix-colors.url = "github:misterio77/nix-colors";
    nixvim.url = "github:pta2002/nixvim";
  };

  outputs = { self, nixpkgs, utils, darwin, home-manager, nur, nix-colors, nixvim }@inputs: utils.lib.mkFlake {
    inherit self inputs;

    homeModules = utils.lib.exportModules [
      ./hm/alacritty.nix
      ./hm/default-home.nix
      ./hm/direnv.nix
      ./hm/eww
      ./hm/firefox.nix
      ./hm/font.nix
      ./hm/kitty.nix
      ./hm/git.nix
      ./hm/nvim.nix
      ./hm/vifm.nix
      ./hm/starship.nix
      ./hm/xmonad
      ./hm/xmobar.nix
      ./hm/yabai-skhd.nix
      ./hm/zsh.nix
    ];

    colorscheme = nix-colors.colorSchemes.nord;
    colorscheme-name = "nord";

    sharedOverlays = [ nur.overlay ];

    channels.nixpkgs = {
      input = nixpkgs;
      config = {
        allowUnfree = true;
      };
    };

    hostDefaults = {
      extraArgs = { inherit utils inputs; };
    };

    hosts.nixos = {
      system = "x86_64-linux";
      modules = [
        ./hosts/nixos/configuration.nix
        self.homeModules.font
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.extraSpecialArgs = {
            colorscheme = self.colorscheme;
            colorscheme-name = self.colorscheme-name;
          };

          home-manager.users.builditluc = { pkgs, ... }:
          {
            imports = with self.homeModules; [
              default-home
              nixvim.homeManagerModules.nixvim

              alacritty
              direnv
              firefox
              git
              nvim
              starship
              xmonad
              zsh
            ];
          };
        }
      ];
    };

    hosts.prlnix = {
      system = "x86_64-linux";
      modules = [
        ./hosts/prlnix/configuration.nix
        self.homeModules.font
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.extraSpecialArgs = {
            colorscheme = self.colorscheme;
            colorscheme-name = self.colorscheme-name;
          };

          home-manager.users.builditluc = { pkgs, ... }:
          {
            imports = with self.homeModules; [
              default-home
              nixvim.homeManagerModules.nixvim

              alacritty
              direnv
              firefox
              git
              nvim
              vifm
              starship
              xmonad
              xmobar
              zsh
            ];
          };
        }
      ];
    };

    hosts.macbook = {
      system = "x86_64-darwin";
      modules = [
        ./hosts/macbook/configuration.nix
        self.homeModules.font
        home-manager.darwinModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = {
            colorscheme = self.colorscheme; 
            colorscheme-name = self.colorscheme-name;
          };

          home-manager.users.builditluc = { pkgs, ... }:
          {
            imports = with self.homeModules; [
              default-home
              nixvim.homeManagerModules.nixvim

              alacritty
              direnv
              firefox
              git
              nvim
              vifm
              starship
              zsh
            ];

            programs.firefox.package = (pkgs.callPackage ./custom-pkgs/firefox { });
            xdg.configFile."nix/nix.conf".text = ''
              experimental-features = nix-command flakes
            '';
          };
        }
      ];
      output = "darwinConfigurations";
      builder = darwin.lib.darwinSystem;
    };
  };
}
