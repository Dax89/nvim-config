(import-macros {: nv-fn : use-pkg : with-require} "macros")

(local packerpath (.. (vim.fn.stdpath "data") "/site/pack/packer/start/packer.nvim"))

(fn packer-installed? [ ]
  (= (vim.fn.empty (vim.fn.glob packerpath)) 0))

(fn packer-startup [usefn]
  (with-require packer
                (packer.startup {1 usefn :config { :display {:open_fn (fn []
                                                                        ((. (require :packer.util)
                                                                            :float) {:border "single"}))}}})))

(local wasinstalled? (packer-installed?))

(when (= (packer-installed?) false)
  (print "Could not find packer.nvim, cloning new copy to" packerpath)
  (nv-fn system ["git" "clone" "https://github.com/wbthomason/packer.nvim" packerpath])
  (vim.api.nvim_command "packadd packer.nvim"))

(packer-startup
  (fn [use]
    ; Lua
    (use-pkg "wbthomason/packer.nvim")         ; Packer can manage itself
    (use-pkg "rktjmp/hotpot.nvim")             ; Fennel Support
    (use-pkg "stevearc/dressing.nvim")         ; UI Component Styling
    (use-pkg "kyazdani42/nvim-web-devicons")
    (use-pkg "kyazdani42/nvim-tree.lua")
    (use-pkg "romgrk/barbar.nvim")
    (use-pkg "nvim-lualine/lualine.nvim")
    (use-pkg "stevearc/aerial.nvim")
    (use-pkg "norcalli/nvim-colorizer.lua")
    (use-pkg "windwp/nvim-autopairs")
    (use-pkg "yamatsum/nvim-cursorline")
    (use-pkg "ahmedkhalf/project.nvim")
    (use-pkg "kristijanhusak/orgmode.nvim")
    (use-pkg "L3MON4D3/LuaSnip")
    (use-pkg "goolord/alpha-nvim")
    (use-pkg "catppuccin/nvim"                 {:as "catppuccin"})
    (use-pkg "VonHeikemen/searchbox.nvim"      {:requires [[:MunifTanjim/nui.nvim]]})
    (use-pkg "nvim-treesitter/nvim-treesitter" {:run ":TSUpdate"})
    (use-pkg "nvim-telescope/telescope.nvim"   {:requires [[:nvim-lua/popup.nvim] [:nvim-lua/plenary.nvim]]})

    ; VimL
    (use-pkg "easymotion/vim-easymotion")
    (use-pkg "voldikss/vim-floaterm")
    (use-pkg "pangloss/vim-javascript")
    (use-pkg "evanleck/vim-svelte")
    (use-pkg "instant-markdown/vim-instant-markdown")
    (use-pkg "MTDL9/vim-log-highlighting")
    (use-pkg "bakpakin/fennel.vim")
    (use-pkg "alaviss/nim.nvim")
    (use-pkg "ziglang/zig.vim")

    ; LSP Support
    (use-pkg "hrsh7th/nvim-cmp")
    (use-pkg "hrsh7th/cmp-nvim-lsp")
    (use-pkg "hrsh7th/cmp-path")
    (use-pkg "neovim/nvim-lspconfig")
    (use-pkg "folke/lsp-trouble.nvim")
    (use-pkg "williamboman/nvim-lsp-installer")
    (use-pkg "onsails/lspkind-nvim")
    (use-pkg "saadparwaiz1/cmp_luasnip")

    ; Lisp Support
    (use-pkg "vlime/vlime")
    (use-pkg "kovisoft/paredit")
    nil))

(when (= wasinstalled? false)
  (vim.api.nvim_command ":PackerInstall"))
