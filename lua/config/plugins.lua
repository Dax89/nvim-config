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
    {"nvim-treesitter/nvim-treesitter-context", as = "ts-context", config = "none"},
    {"nvim-treesitter/nvim-treesitter",         as = "treesitter", after = "ts-context", run = true},
    {"p00f/nvim-ts-rainbow",                    as = "ts-rainbow", after = "treesitter"},
    {"gorbit99/codewindow.nvim",                as = "codewindow", after = "treesitter", config = "setup"},
    {"cshuaimin/ssr.nvim",                      as = "ssr",        module = "ssr"},
    -- TreeSitter --

    {"kyazdani42/nvim-web-devicons", config = "setup"},

    {"VonHeikemen/searchbox.nvim",  as = "searchbox", requires = {"MunifTanjim/nui.nvim"}},
    {"nvim-neo-tree/neo-tree.nvim", as = "neotree",   requires = {"MunifTanjim/nui.nvim"}, branch = "v2.x"},

    {"iamcco/markdown-preview.nvim", ft = "markdown", run = function() vim.fn["mkdp#util#install"]() end},
    {"lukas-reineke/headlines.nvim", as = "headlines", ft = {"markdown", "orgmode", "neorg"}, config = "setup"},

    {"nvim-telescope/telescope-file-browser.nvim", as = "telescope-filebrowser" },
    {"nvim-telescope/telescope.nvim",              as = "telescope",            after = {"telescope-filebrowser"}},
    {"AckslD/nvim-neoclip.lua",                    as = "neoclip",              after = "telescope"},

    {"sam4llis/nvim-tundra",        as = "tundra"},
    {"rcarriga/nvim-notify",        as = "notify",     after = "tundra"},
    {"nvim-lualine/lualine.nvim",   as = "lualine",    after = "tundra"},
    {"akinsho/bufferline.nvim",     as = "bufferline", after = "tundra"},
    {"glepnir/dashboard-nvim",      as = "dashboard",  after = "tundra"},
    {"jbyuki/venn.nvim",            as = "venn"},
    {"nvim-pack/nvim-spectre",      as = "spectre"},
    {"akinsho/toggleterm.nvim",     as = "toggleterm", tag = "*"},
    {"numToStr/Comment.nvim",       as = "Comment", config = "setup"},
    {"norcalli/nvim-colorizer.lua", as = "colorizer", config = "setup" },
    {"windwp/nvim-autopairs",       as = "autopairs"},
    {"phaazon/hop.nvim",            as = "hop"},
    {"nacro90/numb.nvim",           as = "numb"},

    -- LSP Support --
    {"neovim/nvim-lspconfig",             as = "lspconfig"},
    {"williamboman/mason-lspconfig.nvim", as = "mason-lspconfig"},
    {"williamboman/mason.nvim",           as = "mason",              after = {"lspconfig", "mason-lspconfig"}},
    {"stevearc/aerial.nvim",              as = "aerial",             after = {"lspconfig", "treesitter", "telescope"}},
    {"ray-x/lsp_signature.nvim",          as = "lspsignature",       after = "lspconfig"},
    {"onsails/lspkind-nvim",              as = "lspkind",            config = "init"},
    {"p00f/clangd_extensions.nvim",       as = "clangd_extensions",  after = {"lspconfig", "mason-lspconfig"}, config = "setup"},
    {"RRethy/vim-illuminate",             as = "illuminate",         after = "lspconfig"},
    {"folke/trouble.nvim",                as = "trouble",            cmd = "TroubleToggle", config = "setup"},
    {"utilyre/barbecue.nvim",             as = "barbecue",           after = "lspconfig",   requires = {"smiteshp/nvim-navic"}},
    {"j-hui/fidget.nvim",                 as = "fidget",             config = "setup"},
    {"smjonas/inc-rename.nvim",           as = "inc_rename",         after = "lspconfig", config = "setup"},
    {"weilbith/nvim-code-action-menu",    cmd = "CodeActionMenu",    after = "lspconfig"},
    -- LSP Support --

    -- Snippets --
    {"L3MON4D3/LuaSnip",             as = "luasnip"},
    {"rafamadriz/friendly-snippets", as = "friendly_snippets"},
    -- Snippets --

    -- Autocompletion --
    {
        "hrsh7th/nvim-cmp",
        as = "cmp",
        requires = {"saadparwaiz1/cmp_luasnip", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-nvim-lua" },
        after = {"lspconfig", "luasnip", "friendly_snippets", "clangd_extensions" }
    },
    -- Autocompletion --

    -- DAP Support --
    {"mfussenegger/nvim-dap", as = "dap"},
    {"rcarriga/nvim-dap-ui",  as = "dap_ui"},
    -- DAP Support --

    -- Python --
    {"terror/chatgpt.nvim",   as = "chatgpt", run = "pip3 install -r requirements.txt"},
    -- Python --

    "TimUntersberger/neogit",
    {"https://gitlab.com/yorickpeterse/nvim-window", as = "window"},

    -- VimL --
    {"peterhoeg/vim-qml", ft = "qml"},
    {"mechatroner/rainbow_csv", ft = "csv"},
    {"MTDL9/vim-log-highlighting", ft = "log"},
    {"bakpakin/fennel.vim", ft = "fennel"},
    {"alaviss/nim.nvim", ft = "nim"},
    {"ziglang/zig.vim", ft = "zig"}
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
    "rrhelper",
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
}

return {
    disabledbuiltins = DISABLED_BUILTINS,
    plugins = check_dev_mode(PLUGINS),
}
