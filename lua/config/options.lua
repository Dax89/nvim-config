local common = require("config.common")

common.set_options("g", {
    mapleader = " ",
    maplocalleader = ",",
    neovide_cursor_vfx_mode = "railgun",
})

common.set_options("opt", {
    -- General
    mouse = "a",                           -- Mouse interacts with NeoVim
    swapfile = false,                      -- Don"t use swapfile
    completeopt = "menu,menuone,noselect", -- Completion options
    clipboard = "unnamedplus",             -- Use System Clipboard
    colorcolumn = "80,120",                -- Screen Columns

    -- UI
    number = true,         -- Print line number
    showmatch = true,      -- Highlight matching parenthesis
    splitbelow = true,     -- Put new windows below current
    splitright = true,     -- Put new windows right of current
    ignorecase = true,     -- Ignore case
    smartcase = true,      -- Don"t ignore case with capitals
    termguicolors = true,  -- True color support
    laststatus = 3,        -- Set global statusline
    signcolumn = "number", -- LSP Diagnostic column is always visible
    sidescrolloff = 8,     -- Columns of context
    scrolloff = 10,        -- Lines of context
    cursorline = true,     -- Highlight current line
    joinspaces = false,    -- No double spaces with join after a dot
    hlsearch = false,      -- Don't highlight search results
    wrap = false,          -- Disable line wrap

    fillchars = {          -- Redefine UI characters
        foldclose = "",
        foldopen = "",
        vert = "│",
        fold = " ",
        diff = "░",
        msgsep = "",
        foldsep = "│",
        eob = " ",
    },

    -- Tabs & Indent
    expandtab = true,      -- Use spaces instead of tabs
    shiftwidth = 4,        -- Shift 4 spaces when tab
    softtabstop = 4,       -- 4 spaces == 1 tab
    tabstop = 4,           -- 1 tab == 4 spaces
    smartindent = true,    -- Autoindent new lines
    shiftround = true,     -- Round indent
    foldmethod = "indent", -- Indent based folds

    -- Folding
    foldcolumn = "0",   -- Hide fold column
    foldlevel = 99,     -- Minimum fold level that will be closed
    foldenable = false, -- Disable folding by default
    foldtext = "",      -- Normal highlighting and no line wrapping

    -- Performance
    -- lazyredraw = true,      -- Improve performance when running macros
    hidden = true,             -- Enable modified buffers in background
    history = 100,             -- Remember N lines in history

    wildmode = "longest,full", -- Command-line completion mode
})

-- Setup GUI Frontend
if vim.fn.has("gui_running") then
    common.set_options("opt", {
        guifont = "monospace:h14", -- GUI Font
        linespace = -1,            -- Line vertical spacing
    })
end
