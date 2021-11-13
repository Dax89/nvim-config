(import-macros {: plugin-setup} "macros")

(plugin-setup colorizer setup)
(plugin-setup trouble setup)
(plugin-setup lspkind init)

(plugin-setup nvim-tree setup
              {:update_focused_file {:enable true}
               :update_to_buf_dir {:enable true}
               :update_cwd true})
