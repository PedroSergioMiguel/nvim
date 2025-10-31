-- ~/.config/nvim/lua/pedrosergiomiguel/plugins/lsp.lua

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "mfussenegger/nvim-jdtls", -- Dependencia para la configuración de Java
    },
    config = function()
      -- Función on_attach: se ejecuta cuando un LSP se adjunta a un buffer
      local on_attach = function(client, bufnr)
        local map = vim.keymap.set
        local opts = { noremap = true, silent = true, buffer = bufnr }

        map("n", "gD", vim.lsp.buf.declaration, { desc = "Ir a la declaración" })
        map("n", "gd", vim.lsp.buf.definition, { desc = "Ir a la definición" })
        map("n", "K", vim.lsp.buf.hover, { desc = "Mostrar documentación flotante" })
        map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Renombrar símbolo" })
        map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Acciones de código" })
        map("n", "gr", vim.lsp.buf.references, { desc = "Mostrar referencias" })

        if client.supports_method("textDocument/formatting") then
          map("n", "<leader>f", function() vim.lsp.buf.format { async = true } end, { desc = "Formatear código" })
        end
      end

      -- Capacidades del cliente LSP (para nvim-cmp)
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Configuración de Mason y Mason-LSPConfig
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "jdtls",
          "lua_ls",
        },
        handlers = {
          -- Configuración por defecto para la mayoría de los servidores
          function(server_name)
            require("lspconfig")[server_name].setup({
              on_attach = on_attach,
              capabilities = capabilities,
            })
          end,

          -- Configuración específica para Lua
          ["lua_ls"] = function()
            require("lspconfig").lua_ls.setup({
              on_attach = on_attach,
              capabilities = capabilities,
              settings = {
                Lua = {
                  diagnostics = { globals = { "vim" } },
                },
              },
            })
          end,

          -- Configuración AVANZADA y específica para Java (jdtls)
          ["jdtls"] = function()
            require("lspconfig").jdtls.setup({
              on_attach = on_attach,
              capabilities = capabilities,
              cmd = { 'jdtls' },
              root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),
              settings = {
                java = {
                  sources = {
                    organizeImports = {
                      starThreshold = 9999,
                      staticStarThreshold = 9999,
                    },
                  },
                }
              },
              init_options = {
                bundles = {
                  vim.fn.glob(vim.fn.stdpath('data') .. '/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar', 1)
                }
              }
            })
          end,
        }
      })
    end,
  },
}
