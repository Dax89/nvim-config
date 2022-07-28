(import-macros {: nv-opt : nv-cmd} "macros")

(nv-opt g
        :mapleader " "
        :maplocalleader ","
        nil)

(nv-opt opt
        :clipboard "unnamedplus"                  ; Use System Clipboard
        :completeopt "menuone,noinsert,noselect"  ; Completion options
        :wildmode "list:longest"                  ; Command-line completion mode
        :mouse "a"                                ; Mouse interacts with NeoVim
        :signcolumn "yes"                         ; LSP Diagnostic column is always visible
        :sidescrolloff 8                          ; Columns of context
        :scrolloff 4                              ; Lines of context
        :cursorline true                          ; Highlight current line
        :hidden true                              ; Enable modified buffers in background
        :ignorecase true                          ; Ignore case
        :joinspaces false                         ; No double spaces with join after a dot
        :shiftround true                          ; Round indent
        :smartcase true                           ; Don't ignore case with capitals
        :splitbelow true                          ; Put new windows below current
        :splitright true                          ; Put new windows right of current
        :termguicolors true                       ; True color support
        ;:list true                               ; Show some invisible characters (tabs...)
        :number true                              ; Print line number
        :wrap false                               ; Disable line wrap
        nil)

(nv-opt o
        :guifont "FiraCode Nerd Font Mono:h14"
        nil)

(nv-cmd
  "set noswapfile"
  "set autoindent"
  "set expandtab"
  "set shiftwidth=4"
  "set smartindent"
  "set softtabstop=4"
  "set tabstop=4"

  "autocmd BufEnter * silent! lcd %:p:h"
  "autocmd BufNewFile,BufRead,BufEnter *.postcss set syntax=scss"
  "au TextYankPost * silent! lua vim.highlight.on_yank()"

  "syntax enable"
  nil)
