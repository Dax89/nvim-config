(import-macros {: wrap-fn : with-require : nv-keys : nv-cmd} "macros")

(fn show-packer []
  (with-require ui
                (ui.show-menu "Manage Packer" ["Open Configuration" "-" "Sync" "Clean" "-" "Check Health" "Check TS" "Check LSP" "-" "LSP Info"]
                              (lambda [item]
                                (match item._index
                                  1  (nv-cmd (.. ":e " (vim.fn.stdpath "config") "/fnl/config.fnl"))
                                  3  (nv-cmd ":PackerSync")
                                  4  (nv-cmd ":PackerClean")
                                  6  (nv-cmd ":checkhealth")
                                  7  (nv-cmd ":checkhealth nvim_treesitter")
                                  8  (nv-cmd ":checkhealth lspconfig")
                                  10 (nv-cmd ":LspInstallInfo"))))))

(nv-keys ("n" "<A-p>" (wrap-fn :4-ui show-packer) { :noremap true }))

{: show-packer}
