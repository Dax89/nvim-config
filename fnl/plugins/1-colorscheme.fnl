(import-macros {: plugin-setup : nv-cmd} "macros")

(plugin-setup catppuccin setup {:styles {:comments  "NONE"
                                         :functions "NONE"
                                         :keywords  "NONE"
                                         :variables "NONE"}})

(nv-cmd "colorscheme catppuccin")
