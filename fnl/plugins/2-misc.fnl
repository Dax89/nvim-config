(import-macros {: with-require : plugin-setup} "macros")

(plugin-setup colorizer setup)
(plugin-setup trouble setup)
(plugin-setup lspkind init)
(plugin-setup dressing setup)
(plugin-setup renamer setup)

(with-require telescope
              (telescope.load_extension "aerial"))

(plugin-setup lualine setup 
              {:sections {:lualine_x ["aerial"] }
               :options {:theme "catppuccin"}
               :integration {:nvimtree {:enabled true
                                        :show_roow true}}}) 

(plugin-setup nvim-tree setup
              {:update_focused_file {:enable true}
               :update_to_buf_dir {:enable true}
               :update_cwd true})
