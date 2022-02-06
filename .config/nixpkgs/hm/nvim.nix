{ pkgs, config, ... }:
let
  nixvim = import "/Users/builditluc/Developing/nix/nixvim/default.nix";
  # nixvim = import (builtins.fetchGit {
  #   url = "https://github.com/pta2002/nixvim";
  #   rev = "e663c69032f16d963c568d5670708dff262048e3";
  # });
  # nixvim = import (builtins.fetchGit {
  #   url = "https://github.com/builditluc/nixvim";
  #   ref = "main";
  # });
  colorscheme = (import ../colors.nix).colorscheme;
in
{
  imports = [ 
    nixvim.homeManagerModules.nixvim
  ];

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
      normal."<s-j>".action = "<c-w>j";
      normal."<s-k>".action = "<c-w>k";
      normal."<s-h>".action = "<c-w>h";
      normal."<s-l>".action = "<c-w>l";

      normal."<s-v>".action = "<c-w>v";
      normal."<s-s>".action = "<c-w>s";
    };
    colorscheme = "nord";
    globals.mapleader = ";";
    plugins = {
      packer = {
        enable = true;
        plugins = [
          { name = "tami5/lspsaga.nvim"; }
          { name = "ahmedkhalf/project.nvim"; }
          { name = "MunifTanjim/nui.nvim"; }
          { name = "VonHeikemen/fine-cmdline.nvim"; }
          { name = "vifm/vifm.vim"; }
          { name = "mhinz/vim-startify"; }
        ];
      };
      lualine = {
        enable = true;
      };
      telescope = {
        enable = true;
        extensions = {
          fzf-native = {
            enable = true;
            overrideGenericSorter = true;
            overrideFileSorter = true;
          };
        };
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
      intellitab.enable = true;
      treesitter.enable = true;
      floaterm = {
        enable = true;
        autoClose = 1;
      };
      notify.enable = true;
      nvim-autopairs.enable = true;
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
      set noshowmode
      '';
    extraConfigLua = ''
      vim.api.nvim_set_keymap('n', ':', '<cmd>FineCmdline<CR>', {noremap=true})
      require('todo-comments').setup{}

      require('project_nvim').setup{
        patterns = { ".git", "shell.nix", "Makefile", "package.json", "flake.nix" }
      }
      require('telescope').load_extension('projects')

     local __which_key = require('which-key')
__which_key.register({['b'] = {['b'] = {'<cmd>BufferLineCyclePrev<cr>','Previous'},['j'] = {'<cmd>BufferLinePick<cr>','Jump'},['name'] = '+Buffers',['w'] = {'<cmd>bd<cr>','Wipeout'}},['f'] = {['f'] = {'<cmd>Telescope find_files<cr>','Find File'},['j'] = {'<cmd>EditVifm<cr>','vifm'},['name'] = '+Files'},['g'] = {'<cmd>FloatermNew lazygit<cr>','Lazygit'},['gcc'] = {['name'] = 'Comment'},['l'] = {['a'] = {'<cmd>Lspsaga code_action<cr>','Code Actions'},['d'] = {'<cmd>Telescope lsp_definitions<cr>','Definitions'},['k'] = {'<cmd>Lspsaga hover_doc<cr>','Hover Documentation'},['name'] = '+LSP',['r'] = {'<cmd>Lspsaga rename<cr>','Rename'},['t'] = {'<cmd>TroubleToggle<cr>','Toggle Troube'}},['p'] = {'<cmd>Telescope projects<cr>','Open Project'},['q'] = {'<cmd>q<cr>','Quit'},['r'] = {'<cmd>TodoTrouble<cr>','List all project todos'},['t'] = {['name'] = '+Train',['o'] = {'<cmd>TrainTextObj<cr>','Train for movements related to text objects'},['u'] = {'<cmd>TrainUpDown<cr>','Train for movements up and down'},['w'] = {'<cmd>TrainWord<cr>','Train for movements related to words'}},['w'] = {'<cmd>w<cr>','Save'}}, {['mode'] = 'n',['prefix'] = '<leader>'})
      __which_key.setup{['show_help'] = true,['window'] = {['border'] = 'single'}}

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
      require('lualine').setup {
        options = {
          component_separators = { left = "", right = ""},
          section_separators = { left = "", right = ""},
        },
        sections = {
          lualine_a = {"branch", ""},
          lualine_b = {"filename", "diff", diagnostics},
          lualine_c = {""},
          lualine_x = {"filetype", "fileformat"},
          lualine_y = {"progress"},
          lualine_z = {"mode"},
        }
      }
       '';
  };
}
