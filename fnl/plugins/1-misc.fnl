(import-macros {: with-require : plugin-setup : nv-cmd} "macros")

(plugin-setup stickybuf setup)
(plugin-setup colorizer setup)
(plugin-setup trouble setup)
(plugin-setup lspkind init)

(with-require telescope
              (telescope.load_extension "aerial"))

(plugin-setup nvim-tree setup
              {:update_focused_file {:enable true}
               :update_to_buf_dir {:enable true}
               :update_cwd true})
