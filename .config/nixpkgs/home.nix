{ config, pkgs, ... }:
let
  # nixvim = import "/Users/builditluc/Developing/nix/nixvim/default.nix";
  # nixvim = import (builtins.fetchGit {
  #   url = "https://github.com/pta2002/nixvim";
  #   rev = "e663c69032f16d963c568d5670708dff262048e3";
  # });
  nixvim = import (builtins.fetchGit {
    url = "https://github.com/builditluc/nixvim";
    rev = "0cdf927789434e67f756ce6b54b1148874db1c2b";
    ref = "main";
  });
  nix-colors = builtins.fetchTarball "https://github.com/misterio77/nix-colors/archive/main.tar.gz"; 
  colorscheme = (import "${nix-colors}/schemes").nord;
in {
  imports = [ 
    nixvim.homeManagerModules.nixvim
  ];

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

    pkgs.neofetch
    pkgs.onefetch

    pkgs.rustup
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
  programs.direnv = {
    enable = true;
    nix-direnv = {
      enable = true;
    };
  };
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        size = 12.0;
        normal = {
          family = "FiraCode Nerd Font";
          style = "Regular";
        };
        bold = {
          family = "FiraCode Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "FiraCode Nerd Font";
          style = "Italic";
        };
      };
      colors = {
        primary = {
          background = "#${colorscheme.colors.base00}";
          foreground = "#${colorscheme.colors.base04}";
        };
        cursor = {
          text = "#${colorscheme.colors.base00}";
          cursor = "#${colorscheme.colors.base04}";
        };
        vi_mode_cursor = {
          text = "#${colorscheme.colors.base00}";
          cursor = "#${colorscheme.colors.base04}";
        };
        selection = {
          text = "CellForeground";
          background = "#${colorscheme.colors.base03}";
        };
        search = {
          matches = {
            foreground = "CellBackground";
            background = "#${colorscheme.colors.base0C}";
          };
          bar = {
            background = "#${colorscheme.colors.base02}";
            foreground = "#${colorscheme.colors.base04}";
          };
        };
        normal = {
          black = "#${colorscheme.colors.base01}";
          red = "#${colorscheme.colors.base08}";
          green = "#${colorscheme.colors.base0B}";
          yellow = "#${colorscheme.colors.base0A}";
          blue = "#${colorscheme.colors.base0D}";
          magenta = "#${colorscheme.colors.base0E}";
          cyan = "#${colorscheme.colors.base0C}";
          white = "#${colorscheme.colors.base05}";
        };
        bright = {
          black = "#${colorscheme.colors.base03}";
          red = "#${colorscheme.colors.base08}";
          green = "#${colorscheme.colors.base0B}";
          yellow = "#${colorscheme.colors.base0A}";
          blue = "#${colorscheme.colors.base0D}";
          magenta = "#${colorscheme.colors.base0E}";
          cyan = "#${colorscheme.colors.base07}";
          white = "#${colorscheme.colors.base06}";
        };
      };
      window = {
        dimensions = {
          x = 80;
          y = 24;
        };
        decorations = "none";
        padding = {
          x = 10;
          y = 10;
        };
      };
      selection.save_to_clipboard = true;
      cursor.style = {
        shape = "Block";
        blinking = "Off";
      };
      shell.program = "/bin/zsh";
    };
  };
  programs.git = {
    enable = true;
    userEmail = "37375448+Builditluc@users.noreply.github.com";
    userName = "Builditluc";
    ignores = [ "*~" ".DS_Store" ".diff" ];
    extraConfig = {
      core = { editor = "nvim"; };
      pull = { rebase = true; };
    };
  };
  programs.nixvim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    options = {
      number = true;
      relativenumber = true;
      expandtab = true;
      shiftwidth = 2;
      tabstop = 2;
      spell = false;
      spelllang = "en";
      scrolloff = 20;
      cursorline = true;
      mouse = "a";
    };
    maps = {
      normal."<c-k>" = {
        silent = true;
        action = "<cmd>lua require(\"lspsaga.action\").smart_scroll_with_saga(-1)<cr>";
      };
      normal."<c-j>" = {
        silent = true;
        action = "<cmd>lua require(\"lspsaga.action\").smart_scroll_with_saga(1)<cr>";
      };
    };
    colorscheme = "nord";
    globals.mapleader = ";";
    plugins = {
      packer = {
        enable = true;
        plugins = [
          { name = "tami5/lspsaga.nvim"; }
        ];
      };
      lualine = {
        enable = true;
        componentSeparators = {
          left = "";
          right = "";
        };
        sectionSeparators = {
          left = "";
          right = "";
        };
        sections = {
          lualine_a = {
            mode = "branch";
            icon = "";
          };
          lualine_b.mode = "filename";
          lualine_c.mode = "";
          lualine_x.mode = "filetype";
          lualine_y.mode = "";
          lualine_z.mode = "mode";
        };
      };
      telescope = {
        enable = true;
        highlightTheme = "nord";
        extensions.frecency.enable = true;
      };
      bufferline = {
        enable = true;
        showCloseIcon = false;
        separatorStyle = "thin";
        highlights = {
          fill = {
            guifg = "#3a4251";
            guibg = "#3a4251";
          };
        };
      };
      comment-nvim.enable = true;
      nix.enable = true;
      easyescape.enable = true;
      floaterm = {
        enable = true;
        autoClose = 1;
      };
      which-key = {
        enable = true;
        mappings = {
          "gcc" = { name = "Comment"; };
          "f" = [ "<cmd>Telescope find_files<cr>" "Fild File" ];
          "q" = [ "<cmd>q<cr>" "Quit" ];
          "w" = [ "<cmd>w<cr>" "Save" ];
          "b" = {
            name = "+Buffers";
            "b" = [ "<cmd>BufferLineCyclePrev<cr>" "Previous" ];
            "j" = [ "<cmd>BufferLinePick<cr>" "Jump" ];
            "w" = [ "<cmd>bd<cr>" "Wipeout" ];
          };
          "g" = [ "<cmd>FloatermNew lazygit<cr>" "Lazygit" ];
          "l" = {
            name = "+LSP";
            "d" = [ "<cmd>Telescope lsp_definitions<cr>" "Definitions" ];
            "a" = [ "<cmd>Lspsaga code_action<cr>" "Code Actions" ];
            "k" = [ "<cmd>Lspsaga hover_doc<cr>" "Hover Documentation" ];
            "r" = [ "<cmd>Lspsaga rename<cr>" "Rename" ];
            "t" = [ "<cmd>TroubleToggle<cr>" "Toggle Troube" ];
          };
          "r" = [ "<cmd>TodoTrouble<cr>" "List all project todos" ];
          "t" = {
            name = "+Train";
            "u" = [ "<cmd>TrainUpDown<cr>" "Train for movements up and down" ];
            "w" = [ "<cmd>TrainWord<cr>" "Train for movements related to words" ];
            "o" = [ "<cmd>TrainTextObj<cr>" "Train for movements related to text objects" ];
          };
        };
        mappingOptions = {
          mode = "n";
          prefix = "<leader>";
        };
        
        options = {
          showHelp = true;
          window.border = "single";
        };
      };
    };

    extraPlugins = with pkgs.vimPlugins; [
      indent-blankline-nvim
      presence-nvim
      which-key-nvim
      nord-nvim
      lspkind-nvim
      train-nvim
      todo-comments-nvim
      trouble-nvim

      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-vsnip
      cmp-tabnine

      nvim-cmp
      nvim-lspconfig

      vim-vsnip
      vim-lastplace
      vim-wakatime
    ];
    extraConfigVim = ''
      hi WhichKeyFloat guibg=#3A4251
      '';
    extraConfigLua = ''
      require('todo-comments').setup{}

      local lspkind = require('lspkind')
      local source_mapping = {
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        nvim_lua = "[Lua]",
        cmp_tabnine = "[TN]",
        path = "[Path]",
      }

      local tabnine = require('cmp_tabnine.config')
      tabnine:setup({
          max_lines = 1000;
          max_num_results = 10;
          sort = true;
          run_on_every_keystroke = true;
          snippeet_placeholder = '..';
      })


      local cmp = require('cmp')
      cmp.setup({
          snippet = {
              expand = function(args)
                vim.fn["vsnip#anonymous"](args.body)
              end,
              },
          mapping = {
            ['<c-j>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
            ['<c-k>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
          },
          sources = cmp.config.sources({
              { name = 'cmp_tabnine' },
              { name = 'nvim_lsp' },
              { name = 'vsnip'},
            }, {
              { name = 'buffer'},
            }),
          formatting = {
            format = function(entry, vim_item)
              vim_item.kind = lspkind.presets.default[vim_item.kind]
              local menu = source_mapping[entry.source.name]
              if entry.source.name == 'cmp_tabnine' then
                if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
                  menu = entry.completion_item.data.detail .. ' ' .. menu
                end
                vim_item.kind = ''
              end
              vim_item.menu = menu
              return vim_item
            end
          },
        })
      local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
      local servers = { 'rust_analyzer', 'rnix', 'pyright'}
        for _, lsp in ipairs(servers) do
          require('lspconfig')[lsp].setup {
              capabilities = capabilities
            }
        end
      require('lspsaga').setup{}
       '';
  };
}
