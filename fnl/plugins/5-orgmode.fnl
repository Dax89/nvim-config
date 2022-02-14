(import-macros {: with-require-as : plugin-setup} "macros")

; Make TreeSitter aware of "org" syntax
(with-require-as tsparsers nvim-treesitter.parsers
                 (let [parserconfig (tsparsers.get_parser_configs)]
                   (set parserconfig.org {:install_info {:url "https://github.com/milisims/tree-sitter-org"
                                                         :revision "f110024d539e676f25b72b7c80b0fd43c34264ef"
                                                         :files ["src/parser.c" "src/scanner.cc"]}
                                          :filetype "org"})))


(plugin-setup orgmode setup)
