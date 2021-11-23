(import-macros {: nv-opt : nv-keys : nv-fn : with-require : with-require-as} "macros")

(nv-opt g
        :completion_matching_strategy_list ["exact" "fuzzy"]
        :completion_matching_smart_case true
        nil)

(nv-keys ("i" "<Tab>" "compe#complete()" {:noremap false :silent true :expr true}))

; Compe
(with-require compe
  (compe.setup {
    :enabled true
    :autocomplete true
    :debug false
    :min_length 1
    :preselect "enable"
    :throttle_time 80
    :source_timeout 200
    :incomplete_delay 400
    :max_abbr_width 100
    :max_kind_width 100
    :max_menu_width 100
    :documentation true

    :source {
      :path true
      ;:buffer true
      :calc true
      :orgmode true
      :nvim_lsp true
      :nvim_lua true
      :vsnip false
      :ultisnips true
      :conjure true
    }
}))

; Custom LSP Callbacks
(fn setup-lsp-sumneko_lua [server]
  {
   :settings {
      :Lua {
        :diagnostics {
          :globals ["vim"] ; Get the language server to recognize the `vim` global
        }
      }
    }
  })

; LSPInstaller
(fn setup-servers []
  (local SERVERS ["pyright" "tsserver" "svelte" "sumneko_lua" "clangd"])
  (local lspinstaller (require :nvim-lsp-installer))
  (local aerial (require :aerial))
  (local utils (require :utils))
  (var installedcount 0)

  (collect [_ name (ipairs SERVERS)]
           (do
             (local (ok server) (lspinstaller.get_server name))
             (when (and (= ok true) (= (server:is_installed) false))
               (do
                 (print (.. "[nvim-lsp-installer]: Installing " name "..."))
                 (server:install)
                 (set installedcount (+ installedcount 1))))))

  (lspinstaller.on_server_ready (fn [server]
                                  (var opts {:on_attach aerial.on_attach})

                                  (match server.name
                                    "sumneko_lua" (set opts (utils.merge-tables opts (setup-lsp-sumneko_lua))))

                                  (server:setup opts)

                                  (when (> installedcount 0) ; Show LSP Installation Dialog
                                    (vim.api.nvim_command ":LspInstallInfo")))))

(setup-servers)

