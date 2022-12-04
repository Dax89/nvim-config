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
    {"wbthomason/packer.nvim",   noconfig = true},  -- Packer can manage itself
    {"lewis6991/impatient.nvim", noconfig = true},  -- https://github.com/neovim/neovim/pull/15436
    {"nvim-lua/plenary.nvim",    noconfig = true},  -- Misc Utilities
    {"stevearc/dressing.nvim",   noconfig = true, config = function() require("dressing").setup() end},
    {"famiu/bufdelete.nvim",     noconfig = true},
    {"folke/which-key.nvim",     as = "whichkey"},

    -- TreeSitter --
    {"nvim-treesitter/nvim-treesitter-context", as = "ts-context", noconfig = true},
    {"nvim-treesitter/nvim-treesitter",         as = "treesitter", after = "ts-context", run = true},
    {"p00f/nvim-ts-rainbow",                    as = "ts-rainbow", after = "treesitter"},
    {"gorbit99/codewindow.nvim",                as = "codewindow", after = "treesitter", config = function() require("codewindow").setup() end},
    {"cshuaimin/ssr.nvim",                      as = "ssr",        module = "ssr"},
    -- TreeSitter --

    {"rcarriga/nvim-notify",         config = function() require("notify") end},
    {"kyazdani42/nvim-web-devicons", config = function() require("nvim-web-devicons").setup() end},

    {"VonHeikemen/searchbox.nvim",  as = "searchbox", requires = {"MunifTanjim/nui.nvim"}},
    {"nvim-neo-tree/neo-tree.nvim", as = "neotree",   requires = {"MunifTanjim/nui.nvim"}, branch = "v2.x"},

    {"iamcco/markdown-preview.nvim", ft = "markdown", run = function() vim.fn["mkdp#util#install"]() end},
    {"lukas-reineke/headlines.nvim", as = "headlines", ft = {"markdown", "orgmode", "neorg"}, config = function() require("headlines").setup() end},

    {"nvim-telescope/telescope-file-browser.nvim", as = "telescope-filebrowser" },
    {"nvim-telescope/telescope.nvim",              as = "telescope",            after = {"telescope-filebrowser"}},
    {"AckslD/nvim-neoclip.lua",                    as = "neoclip",              after = "telescope"},

    {"sam4llis/nvim-tundra",        as = "tundra"},
    {"nvim-lualine/lualine.nvim",   as = "lualine",    after = "tundra"},
    {"akinsho/bufferline.nvim",     as = "bufferline", after = "tundra"},
    {"glepnir/dashboard-nvim",      as = "dashboard",  after = "tundra"},
    {"jbyuki/venn.nvim",            as = "venn"},
    {"nvim-pack/nvim-spectre",      as = "spectre"},
    {"akinsho/toggleterm.nvim",     as = "toggleterm", tag = "*"},
    {"numToStr/Comment.nvim",       as = "comment",    config = function() require("Comment").setup() end },
    {"norcalli/nvim-colorizer.lua", as = "colorizer",  config = function() require("colorizer").setup() end },
    {"windwp/nvim-autopairs",       as = "autopairs"},
    {"phaazon/hop.nvim",            as = "hop"},
    {"nacro90/numb.nvim",           as = "numb"},

    -- LSP Support --
    {"neovim/nvim-lspconfig",             as = "lspconfig"},
    {"williamboman/mason-lspconfig.nvim", as = "mason-lspconfig"},
    {"williamboman/mason.nvim",           as = "mason",             after = {"lspconfig", "mason-lspconfig"}},
    {"stevearc/aerial.nvim",              as = "aerial",            after = {"lspconfig", "treesitter", "telescope"}},
    {"onsails/lspkind-nvim",              as = "lspkind",           config = function() require("lspkind").init() end},
    {"p00f/clangd_extensions.nvim",       as = "clangd-extensions", after = {"lspconfig", "mason-lspconfig"}, config = function() require("clangd_extensions").setup() end},
    {"RRethy/vim-illuminate",             as = "illuminate",        after = "lspconfig"},
    {"weilbith/nvim-code-action-menu",    cmd = "CodeActionMenu",   after = "lspconfig"},
    {"folke/trouble.nvim",                cmd = "TroubleToggle",    config = function() require("trouble").setup() end},
    -- LSP Support --

    -- Snippets --
    {"L3MON4D3/LuaSnip", as = "luasnip"},
    "rafamadriz/friendly-snippets",
    -- Snippets --

    -- Autocompletion --
    {
        "hrsh7th/nvim-cmp",
        as = "cmp",
        requires = {"saadparwaiz1/cmp_luasnip", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-nvim-lua" },
        after = {"lspconfig", "luasnip", "friendly-snippets", "clangd-extensions" }
    },
    -- Autocompletion --

    -- DAP Support --
    {"mfussenegger/nvim-dap", as = "dap"},
    {"rcarriga/nvim-dap-ui",  as = "dap-ui"},
    -- DAP Support --

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
    "matchit",
    "matchparen",
    "logiPat",
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
