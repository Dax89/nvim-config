local PACKER_PATH = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

local function is_packer_installed()
    return vim.fn.empty(vim.fn.glob(PACKER_PATH)) == 0
end

local function packer_startup(plugins)
    local packer = require("packer")

    packer.init({
        compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua",

        display = {
            open_fn = function()
                return require("packer.util").float({ border = "single" })
            end
        }
    })

    packer.reset()

    packer.startup(function(use)
        for _, plugin in ipairs(plugins) do
            use(plugin)
        end
    end)
end

local WAS_INSTALLED = is_packer_installed()

if not is_packer_installed() then
    print("Could not find packer.nvim, cloning new copy to", PACKER_PATH)
    vim.fn.system({"git", "clone", "https://github.com/wbthomason/packer.nvim", PACKER_PATH})
    vim.api.nvim_command("packadd packer.nvim")
end

packer_startup({
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
})


if not WAS_INSTALLED then
    require("packer").sync()
end
