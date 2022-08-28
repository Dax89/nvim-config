local PLUGINS = {
    -- Lua
    "wbthomason/packer.nvim",         -- Packer can manage itself
    "lewis6991/impatient.nvim",       -- https://github.com/neovim/neovim/pull/15436
    "stevearc/dressing.nvim",         -- UI Component Styling
    "nvim-lua/plenary.nvim",
    "kyazdani42/nvim-web-devicons",
    "famiu/bufdelete.nvim",
    "akinsho/bufferline.nvim",
    "nvim-lualine/lualine.nvim",
    "kevinhwang91/nvim-bqf",
    "weilbith/nvim-code-action-menu",
    "norcalli/nvim-colorizer.lua",
    "windwp/nvim-autopairs",
    "RRethy/vim-illuminate",
    "ahmedkhalf/project.nvim",
    "nvim-orgmode/orgmode",
    "L3MON4D3/LuaSnip",
    "goolord/alpha-nvim",
    "phaazon/hop.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-treesitter/nvim-treesitter-context",
    "numToStr/Comment.nvim",
    "nacro90/numb.nvim",
    "TimUntersberger/neogit",
    "p00f/nvim-ts-rainbow",
    {"AckslD/nvim-neoclip.lua",         requires = {"nvim-telescope/telescope.nvim"}},
    {"nvim-neo-tree/neo-tree.nvim",     branch = "v2.x", requires = {"nvim-lua/plenary.nvim", "kyazdani42/nvim-web-devicons", "MunifTanjim/nui.nvim"}},
    {"akinsho/toggleterm.nvim",         tag = "v2.*"},
    {"catppuccin/nvim",                 as = "catppuccin"},
    {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"},
    {"Shatur/neovim-cmake",             requires = {"mfussenegger/nvim-dap", "nvim-lua/plenary.nvim"}},
    {"VonHeikemen/searchbox.nvim",      requires = {"MunifTanjim/nui.nvim"}},
    {"nvim-telescope/telescope.nvim",   requires = {"nvim-lua/popup.nvim", "nvim-lua/plenary.nvim"}},
    "https://gitlab.com/yorickpeterse/nvim-window",

    -- VimL
    "peterhoeg/vim-qml",
    "mechatroner/rainbow_csv",
    "pangloss/vim-javascript",
    "evanleck/vim-svelte",
    "instant-markdown/vim-instant-markdown",
    "MTDL9/vim-log-highlighting",
    "bakpakin/fennel.vim",
    "alaviss/nim.nvim",
    "ziglang/zig.vim",

    -- DAP Support
    "mfussenegger/nvim-dap",
    "rcarriga/nvim-dap-ui",

    -- LSP Support
    "p00f/clangd_extensions.nvim",
    "simrat39/symbols-outline.nvim",
    "glepnir/lspsaga.nvim",
    "rafamadriz/friendly-snippets",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "neovim/nvim-lspconfig",
    "folke/trouble.nvim",
    "williamboman/nvim-lsp-installer",
    "onsails/lspkind-nvim",
    "saadparwaiz1/cmp_luasnip",

    -- External packages
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim"
}

local DISABLED_BUILTINS = {
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "gzip",
    "zip",
    "zipPlugin",
    "tar",
    "tarPlugin",
    "getscript",
    "getscriptPlugin",
    "vimball",
    "vimballPlugin",
    "2html_plugin",
    "logipat",
    "rrhelper",
    "spellfile_plugin",
    "matchit"
}

return {
    disabledbuiltins = DISABLED_BUILTINS,
    plugins = PLUGINS,
}
