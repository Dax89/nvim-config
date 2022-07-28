(import-macros {: plugin-setup : nv-cmd} "macros")

(plugin-setup catppuccin setup {:styles {:comments  {}
                                         :functions {}
                                         :keywords  {}
                                         :variables {}}})

(nv-cmd "colorscheme catppuccin")
