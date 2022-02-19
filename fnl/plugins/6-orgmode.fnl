(import-macros {: with-require : plugin-setup} "macros")

(with-require orgmode
              (orgmode.setup_ts_grammar)
              (plugin-setup nvim-treesitter.configs setup {:highlight {:enable true
                                                                       :disable ["org"]
                                                                       :additional_vim_regex_highlighting ["org"]}
                                                           :ensure_installed ["org"]})
              (orgmode.setup))
