(import-macros {: with-require-as} "macros")

(macro wrap-fn [name]
  (.. ":lua require('4-ui')['" (tostring name) "']()<CR>"))

(macro create-ui [type title options]
  `(,type {:border {:style "single"
                    :highlight "FloatBorder"
                    :text {:top ,title :top_align "left"}}
           :position "50%" } ,options))

(macro show-menu [title items ?onsubmit]
  `(with-require-as m# "nui.menu"
    (local menu# (create-ui m# ,title
                    {:on_submit ,(or ?onsubmit nil)
                     :lines (icollect [_# v# (ipairs ,items)]
                              (if (= v# "-") ; Check for separator
                                (values (m#.separator))
                                (values (m#.item v#))))}))
    (menu#:mount)))

(fn show-packer []
  (show-menu "Manage Packer" [ "Open Configuration" "-" "Sync" "Clean" "Compile" "-" "Check Health" "Check TS" "Check LSP" "-" "LSP Info"]
    (lambda [item]
      (match item._index
         1 (vim.api.nvim_command (.. ":e " (vim.fn.stdpath "config") "/fnl/config.fnl"))
         3 (vim.api.nvim_command ":PackerSync")
         4 (vim.api.nvim_command ":PackerClean")
         5 (vim.api.nvim_command ":PackerCompile")
         7 (vim.api.nvim_command ":checkhealth")
         8 (vim.api.nvim_command ":checkhealth nvim_treesitter")
         9 (vim.api.nvim_command ":checkhealth lspconfig")
        11 (vim.api.nvim_command ":LspInstallInfo")
        ))))

(vim.api.nvim_set_keymap "n" "<A-p>" (wrap-fn show-packer) { :noremap true })

{: show-packer}
