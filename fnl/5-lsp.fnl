(import-macros {: nv-opt : nv-keys : with-require : nv-fn : plugin-setup} "macros")

(nv-opt g
        :completion_matching_strategy_list ["exact" "fuzzy"]
        :completion_matching_smart_case true
        nil)

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

  (each [_ name (ipairs SERVERS)]
    (do
      (local (ok server) (lspinstaller.get_server name))
      (when (and (= ok true) (= (server:is_installed) false))
        (do
          (print (.. "[nvim-lsp-installer]: Installing " name "..."))
          (server:install)
          (set installedcount (+ installedcount 1))))))

  (lspinstaller.on_server_ready (fn [server]
                                  (var opts {:on_attach aerial.on_attach})

                                  (with-require lspconfig
                                                (local capabilities ((. (require :cmp_nvim_lsp) :update_capabilities) (vim.lsp.protocol.make_client_capabilities)))
                                                ((. (. lspconfig server.name) :setup) {: capabilities}))

                                  (match server.name
                                    "sumneko_lua" (set opts (utils.merge-tables opts (setup-lsp-sumneko_lua))))

                                  (server:setup opts)

                                  (when (> installedcount 0) ; Show LSP Installation Dialog
                                    (vim.api.nvim_command ":LspInstallInfo")))))

(setup-servers)

