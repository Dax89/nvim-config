local Path = require("plenary.path")

local function check_dev_mode(plugins)
    local devmode = Path:new(vim.fn.stdpath("config"), ".dev"):is_file()

    if devmode then
        plugins = vim.list_extend(plugins, {"~/Programmazione/Progetti/NVim/IDE.nvim"})
    else
        plugins = vim.list_extend(plugins, {"Dax89/IDE.nvim"})
    end

    return plugins
end

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
    "rcarriga/nvim-notify",
    "weilbith/nvim-code-action-menu",
    "norcalli/nvim-colorizer.lua",
    "windwp/nvim-autopairs",
    "nvim-orgmode/orgmode",
    "glepnir/dashboard-nvim",
    "phaazon/hop.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-treesitter/nvim-treesitter-context",
    "numToStr/Comment.nvim",
    "nacro90/numb.nvim",
    "jbyuki/venn.nvim",
    "TimUntersberger/neogit",
    "gorbit99/codewindow.nvim",
    "p00f/nvim-ts-rainbow",
    "RRethy/vim-illuminate",
    "nvim-pack/nvim-spectre",
    "sam4llis/nvim-tundra",
    {"cshuaimin/ssr.nvim",              module = "ssr"},
    {"AckslD/nvim-neoclip.lua",         requires = {"nvim-telescope/telescope.nvim"}},
    {"nvim-neo-tree/neo-tree.nvim",     branch = "v2.x", requires = {"nvim-lua/plenary.nvim", "kyazdani42/nvim-web-devicons", "MunifTanjim/nui.nvim"}},
    {"akinsho/toggleterm.nvim",         tag = "v2.*"},
    {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"},
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
    "neovim/nvim-lspconfig",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "onsails/lspkind-nvim",
    "stevearc/aerial.nvim",
    "p00f/clangd_extensions.nvim",
    "folke/trouble.nvim",

    -- Autocompletion
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",
    "saadparwaiz1/cmp_luasnip",

    -- Snippets
    "L3MON4D3/LuaSnip",
    "rafamadriz/friendly-snippets",
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
    plugins = check_dev_mode(PLUGINS),
}
