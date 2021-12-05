(import-macros {: with-require : nv-cmd} "macros")

(local LOGO ["  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗  "
             "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║  "
             "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║  "
             "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║  "
             "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║  "
             "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝  "])

(local BUTTONS [["e" " ➤ New File"     ":ene <BAR> startinsert <CR>"]
                ["r" " ➤ Recents"      ":Telescope oldfiles<CR>"]
                ["u" " ➤ Sync Plugins" ":PackerSync<CR>"]
                ["x" " ➤ Settings"     ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR> "]
                ["q" " ➤ Quit"         ":qa<CR>"]])

(fn get-footer []
  (let [v (vim.version) datetime (os.date "%d-%m-%Y")]
    (local version (string.format "NeoVIM %d.%d.%d (API Level %d)" v.major v.minor v.patch v.api_level))
    (.. version "  " datetime)))

(with-require alpha 
              (local dashboard (require "alpha.themes.dashboard"))

              (set dashboard.section.header.val LOGO)
              (set dashboard.section.header.opts.hl "Identifier")
              (set dashboard.section.footer.val (get-footer))
              (set dashboard.section.footer.opts.hl "Constant")

              (set dashboard.section.buttons.val (icollect [_ b (ipairs BUTTONS)]
                                                           (let [button (dashboard.button (unpack b))]
                                                             (set button.opts.hl "Function")
                                                             (set button.opts.hl_shortcut "Type")
                                                             button)))

              (alpha.setup dashboard.opts))

(nv-cmd "autocmd FileType alpha set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2")
