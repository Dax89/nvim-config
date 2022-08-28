local common = require("config.common")

common.set_options("g", {
    mapleader = " ",
    maplocalleader = ",",

    bufferline = {
        maximum_padding = 1,
        auto_hide = false,
        icons = "both",
        exclude_ft = common.filetype_blacklist
    }
})

common.set_options("opt", {
    -- General
    mouse = "a",                               -- Mouse interacts with NeoVim
    clipboard = "unnamedplus",                 -- Use System Clipboard
    swapfile = false,                          -- Don"t use swapfile
    completeopt = "menu,menuone,noselect",     -- Completion options

    -- Neovim UI
    number = true,                             -- Print line number
    showmatch = true,                          -- Highlight matching parenthesis
    foldmethod = "marker",                     -- Enable folding
    splitbelow = true,                         -- Put new windows below current
    splitright = true,                         -- Put new windows right of current
    ignorecase = true,                         -- Ignore case
    smartcase = true,                          -- Don"t ignore case with capitals
    termguicolors = true,                      -- True color support
    laststatus = 3,                            -- Set global statusline
    signcolumn = "yes",                        -- LSP Diagnostic column is always visible
    sidescrolloff = 8,                         -- Columns of context
    scrolloff = 4,                             -- Lines of context
    cursorline = true,                         -- Highlight current line
    joinspaces = false,                        -- No double spaces with join after a dot
    wrap = false,                              -- Disable line wrap

    -- Tabs, indent
    expandtab = true,                          -- Use spaces instead of tabs
    shiftwidth = 4,                            -- Shift 4 spaces when tab
    softtabstop = 4,                           -- 4 spaces == 1 tab
    tabstop = 4,                               -- 1 tab == 4 spaces
    smartindent = true,                        -- Autoindent new lines
    shiftround = true,                         -- Round indent

    -- Memory, CPU
    hidden = true,                             -- Enable modified buffers in background
    history = 100,                             -- Remember N lines in history

    wildmode = "longest,full",                 -- Command-line completion mode
})

require("catppuccin").setup({
    styles = {
        comments = { },
        functions = { },
        keywords = { },
        variables = { },
    },
    integration = {
        neotree = {
            enabled = true,
            show_root = true,
            transparent_panel = false,
        },
        dap = {
            enabled = true,
            enable_ui = true,
        }
    }
})

common.exec_commands("colorscheme catppuccin")
