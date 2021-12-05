(import-macros {: with-require-as : plugin-setup} "macros")

; Make TreeSitter aware of "org" syntax
(with-require-as tsparsers nvim-treesitter.parsers
                 (let [parserconfig (tsparsers.get_parser_configs)]
                   (set parserconfig.org {:install_info {:url "https://github.com/milisims/tree-sitter-org"
                                                         :revision "main"
                                                         :files ["src/parser.c" "src/scanner.cc"]}
                                          :filetype "org"})))


(plugin-setup orgmode setup)
