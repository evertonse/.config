local overrides = require('custom.plugins.opts')

local M  = {}

M.plugins = {

    { "moll/vim-bbye",                          }, -- Avoid messing with windwos layouts when closing buffers
    { "lewis6991/impatient.nvim",               },

    {
        'VonHeikemen/lsp-zero.nvim',
        dependencies = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'saadparwaiz1/cmp_luasnip'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-nvim-lua'},

            -- Snippets
            {'L3MON4D3/LuaSnip'},
            {'rafamadriz/friendly-snippets'},
        },
    },
    { "onsails/lspkind.nvim",}, -- better lsp cmp icons
    { "jose-elias-alvarez/null-ls.nvim",        }, -- for formatters and linters
    { "RRethy/vim-illuminate",                  },
    { "folke/trouble.nvim",                   }, -- LPS Diagnostic with colors and shit
    { 'folke/lsp-colors.nvim',                }, -- LSP colors that might be missings
    -- { 'jackguo380/vim-lsp-cxx-highlight',     }, -- LSP based cpp highlighting
    -->> Telescope
    {
        "nvim-telescope/telescope.nvim",
        opts = overrides.telescope,
    },
    -- Fuzzy Finder Algorithm which dependencies local dependencies to be built. Only load if `make` is available
    { 'nvim-telescope/telescope-fzf-native.nvim', 
        run = 'make', 
        cond = vim.fn.executable 'make' == 1 
    },
    {'NvChad/nvim-colorizer.lua',             },

    --Optionally  mine https://github.com/evertonse/nvim-treesitter, removed bug with windows that wasnt adressed nor have I seen any issues opened
    --{'evertonse/nvim-treesitter'},
    {"JoosepAlviste/nvim-ts-context-commentstring",     }, -- Nice Vim commenting --  context_commentstring { enable = true },
    -- {'David-Kunz/markid',                                                                       }, -- Every identifier has the same color
    {'nvim-treesitter/playground',                      },

    -- Argument Coloring
    -- {'octol/vim-cpp-enhanced-highlight',                }, -- still haven't d but adds cpp keywords for highlight tweak even further
    {'m-demare/hlargs.nvim', opts = overrides.hlargs},

        -->> Git
    {"lewis6991/gitsigns.nvim",                         },

        -->> Colorschemes
     {'marko-cerovac/material.nvim'},
     { "folke/tokyonight.nvim",  },
    -- { "lunarvim/darkplus.nvim",  },
    -- 'tomasiser/vim-code-dark'
    -- 'shaunsingh/nord.nvim'
    -- Another vs code theme:
    -- for more options see: https://github.com/Mofiqul/vscode.nvim
    -- 'Mofiqul/vscode.nvim'

    --[[ 
        Using my fork of Mofiqul vscode nvim theme, 
        but my theme is Focusing on Visual Studio Theme, rather tha vs code
    --]]
    -- {'evertonse/vs.nvim', branch = "base",            }, --  this for bare minimum, first commit and base branch
    {'evertonse/vs.nvim', branch = "dev"},

    -->> Utils
    {'dstein64/vim-startuptime',                      },
    {'tpope/vim-surround',                            },

    { --https://github.com/andymass/vim-matchup
        'andymass/vim-matchup',
        setup = function()
            -- may set any options here
            vim.g.matchup_matchparen_offscreen = { method = "popup"}
        end
    },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },
}

return M.plugins
