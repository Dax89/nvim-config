(import-macros {: nv-api : with-require : with-require-as} "macros")

(with-require cmp
              (local luasnip (require "luasnip"))
              (local has-words-before (lambda []
                                        (local (line col) (unpack (nv-api nvim_win_get_cursor 0)))
                                        (and (not= col 0) (= (: (: (. (nv-api nvim_buf_get_lines 0 (- line 1) line
                                                                              true)
                                                                      1) :sub col col) :match
                                                                "%s") nil))))

              (with-require-as fromvscode luasnip/loaders/from_vscode
                               (local snippets [(.. (vim.fn.stdpath "data") "/site/pack/packer/start/friendly-snippets")
                                                (.. (vim.fn.stdpath "config") "/snippet")])
                               (fromvscode.lazy_load {:paths snippets}))

              (cmp.setup {
                          :snippet {
                                    :expand (lambda [args]
                                              (luasnip.lsp_expand args.body))}
                          :mapping {
                                    "<C-b>"     (cmp.mapping (cmp.mapping.scroll_docs -4) ["i" "c"])
                                    "<C-f>"     (cmp.mapping (cmp.mapping.scroll_docs 4) ["i" "c"])
                                    "<C-Space>" (cmp.mapping (cmp.mapping.complete) ["i" "c"])
                                    "<C-e>"     (cmp.mapping {:i (cmp.mapping.abort) :c (cmp.mapping.close)})
                                    "<CR>"      (cmp.mapping.confirm {:select true})
                                    "<TAB>"     (cmp.mapping (lambda [fallback]
                                                               (if
                                                                 (= (cmp.visible) true) (cmp.select_next_item)
                                                                 (= (luasnip.expand_or_jumpable) true) (luasnip.expand_or_jump)
                                                                 (= (has-words-before) true) (cmp.complete)
                                                                 (fallback))) ["i" "s"])
                                    "<S-TAB>"     (cmp.mapping (lambda [fallback]
                                                                 (if
                                                                   (= (cmp.visible) true) (cmp.select_prev_item)
                                                                   (= (luasnip.jumpable -1) true) (luasnip.expand_or_jump)
                                                                   (= (has-words-before) true) (cmp.complete)
                                                                   (fallback))) ["i" "s"]) }

                          :sources (cmp.config.sources {
                                                        1 {:name "nvim_lsp"}
                                                        2 {:name "nvim_lua"}
                                                        3 {:name "luasnip"}
                                                        4 {:name "path"}
                                                        5 {:name "orgmode"}})}))

