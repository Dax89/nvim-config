(import-macros {: wrap-fn : nv-keys : nv-cmd} "macros")

(fn show-packer []
  (vim.ui.select [" Settings" " Sync Plugins" "✘ Clean Plugins" "♥ NVIM" "♥ TreeSitter" "♥ LSP" "ǃ Install Info"] 
                 { :prompt "Manage Packer" }
                 (fn [_ idx]
                   (match idx
                     1 (nv-cmd ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd")
                     2 (nv-cmd ":PackerSync")
                     3 (nv-cmd ":PackerClean")
                     4 (nv-cmd ":checkhealth")
                     5 (nv-cmd ":checkhealth nvim_treesitter")
                     6 (nv-cmd ":checkhealth lspconfig")
                     7 (nv-cmd ":LspInstallInfo")))))

(nv-keys ("n" "<A-p>" (wrap-fn :4-ui show-packer) { :noremap true }))

{: show-packer}
