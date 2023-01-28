local function check_dev_mode(plugins)
    local PATH_SEP = vim.loop.os_uname().sysname == "Windows" and "\\" or "/"
    local AFTER = {"mason"}
    local devmode = vim.fn.filereadable(vim.fn.stdpath("config") .. PATH_SEP .. ".dev") == 1

    if devmode then
        plugins = vim.list_extend(plugins, {{"~/Programmazione/Progetti/NVim/IDE.nvim", as = "ide", after = AFTER}})
    else
        plugins = vim.list_extend(plugins, {{"Dax89/IDE.nvim", as = "ide", after = AFTER}})
    end

    return plugins
end

local PLUGINS = {
    -- Lua
    {"wbthomason/packer.nvim",   config = "none"},  -- Packer can manage itself
    {"lewis6991/impatient.nvim", config = "none"},  -- https://github.com/neovim/neovim/pull/15436
    {"nvim-lua/plenary.nvim",    config = "none"},  -- Misc Utilities
    {"stevearc/dressing.nvim",   config = "setup", as = "dressing"},
    {"famiu/bufdelete.nvim",     config = "none"},
    {"folke/which-key.nvim",     as = "whichkey"},

    -- TreeSitter --
    {"nvim-treesitter/nvim-treesitter",         as = "treesitter", run = true},
    {"p00f/nvim-ts-rainbow",                    as = "ts-rainbow", after = "treesitter"},
    {"gorbit99/codewindow.nvim",                as = "codewindow", after = "treesitter", config = "setup"},
    {"cshuaimin/ssr.nvim",                      as = "ssr",        module = "ssr"},
    -- TreeSitter --

    {"kyazdani42/nvim-web-devicons", config = "setup"},

    {"VonHeikemen/searchbox.nvim",  as = "searchbox", requires = {"MunifTanjim/nui.nvim"}, cmd = {"SearchBoxMatchAll", "SearchBoxReplace"}},
    {"nvim-neo-tree/neo-tree.nvim", as = "neotree",   requires = {"MunifTanjim/nui.nvim"}, branch = "v2.x"},

    {"ellisonleao/glow.nvim",        as = "glow",      ft = "markdown", config = "setup"},
    {"lukas-reineke/headlines.nvim", as = "headlines", ft = {"markdown", "orgmode", "neorg"}},

    {"nvim-telescope/telescope-file-browser.nvim", as = "telescope-filebrowser"},
    {"nvim-telescope/telescope.nvim",              as = "telescope",            after = {"telescope-filebrowser"}},
    {"AckslD/nvim-neoclip.lua",                    as = "neoclip",              after = "telescope"},

    {"rebelot/kanagawa.nvim",       as = "kanagawa"},
    {"rcarriga/nvim-notify",        as = "notify",     after = "kanagawa"},
    {"nvim-lualine/lualine.nvim",   as = "lualine",    after = "kanagawa"},
    {"akinsho/bufferline.nvim",     as = "bufferline", after = "kanagawa"},
    {"glepnir/dashboard-nvim",      as = "dashboard",  after = "kanagawa", commit = "f7d623457d6621b25a1292b24e366fae40cb79ab"},
    {"nvim-pack/nvim-spectre",      as = "spectre",    config = "setup"},
    {"numToStr/Comment.nvim",       as = "Comment",    config = "setup"},
    {"norcalli/nvim-colorizer.lua", as = "colorizer",  config = "setup"},
    {"phaazon/hop.nvim",            as = "hop",        config = "setup"},
    {"akinsho/toggleterm.nvim",     as = "toggleterm", tag = "*"},
    {"jbyuki/venn.nvim",            as = "venn"},
    {"windwp/nvim-autopairs",       as = "autopairs"},
    {"nacro90/numb.nvim",           as = "numb"},
    {"kylechui/nvim-surround",      config = "setup"},

    -- LSP Support --
    {"neovim/nvim-lspconfig",             as = "lspconfig"},
    {"williamboman/mason-lspconfig.nvim", as = "mason-lspconfig"},
    {"williamboman/mason.nvim",           as = "mason",              after = {"lspconfig", "mason-lspconfig"}},
    {"stevearc/aerial.nvim",              as = "aerial",             after = {"lspconfig", "treesitter", "telescope"}},
    {"ray-x/lsp_signature.nvim",          as = "lspsignature",       after = "lspconfig"},
    {"onsails/lspkind-nvim",              as = "lspkind"},
    {"RRethy/vim-illuminate",             as = "illuminate",         after = "lspconfig"},
    {"folke/trouble.nvim",                as = "trouble",            cmd = "TroubleToggle", config = "setup"},
    {"utilyre/barbecue.nvim",             as = "barbecue",           after = "lspconfig",   requires = {"smiteshp/nvim-navic"}},
    {"j-hui/fidget.nvim",                 as = "fidget",             config = "setup"},
    {"smjonas/inc-rename.nvim",           as = "inc_rename",         after = "lspconfig", config = "setup"},
    {"weilbith/nvim-code-action-menu",    cmd = "CodeActionMenu",    after = "lspconfig"},
    -- LSP Support --

    -- Snippets --
    {"L3MON4D3/LuaSnip",             as = "luasnip",          tag = "*"},
    {"rafamadriz/friendly-snippets", as = "friendly_snippets"},
    -- Snippets --

    -- Autocompletion --
    {
        "hrsh7th/nvim-cmp",
        as = "cmp",
        requires = {"saadparwaiz1/cmp_luasnip", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-nvim-lua" },
        after = {"lspconfig", "luasnip", "friendly_snippets"}
    },
    -- Autocompletion --

    -- DAP Support --
    {"mfussenegger/nvim-dap", as = "dap"},
    {"rcarriga/nvim-dap-ui",  as = "dap_ui"},
    -- DAP Support --

    {"TimUntersberger/neogit",                       cmd = "Neogit"},
    {"https://gitlab.com/yorickpeterse/nvim-window", as = "window"},

    -- VimL --
    {"peterhoeg/vim-qml",          ft = "qml",    as = "qml_syntax"},
    {"mechatroner/rainbow_csv",    ft = "csv",    as = "csv_syntax"},
    {"MTDL9/vim-log-highlighting", ft = "log",    as = "log_syntax"},
    {"bakpakin/fennel.vim",        ft = "fennel", as = "fennel_syntax"},
    {"alaviss/nim.nvim",           ft = "nim",    as = "nim_syntax"},
    {"ziglang/zig.vim",            ft = "zig",    as = "zig_syntax"},
    -- VimL --
}

local DISABLED_BUILTINS = {
    "gzip",
    "zip",
    "zipPlugin",
    "fzf",
    "tar",
    "tarPlugin",
    "getscript",
    "getscriptPlugin",
    "vimball",
    "vimballPlugin",
    "2html_plugin",
    "logipat",
    "spellfile_plugin";
    "rrhelper",
    "matchit",
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
}

return {
    disabledbuiltins = DISABLED_BUILTINS,
    plugins = check_dev_mode(PLUGINS),
}
