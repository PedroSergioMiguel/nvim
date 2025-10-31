-- ~/.config/nvim/lua/pedrosergiomiguel/plugins/lsp.lua

return {
  -- LSP, Mason e Integración
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "jdtls",
          "lua_ls",
        }
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "mfussenegger/nvim-jdtls", -- Dependencia para la configuración de Java
    },
    config = function ()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Función on_attach: se ejecuta cuando un LSP se adjunta a un buffer
      local on_attach = function(client, bufnr)
        local map = vim.keymap.set
        local opts = { noremap = true, silent = true, buffer = bufnr }

        map("n", "gD", vim.lsp.buf.declaration, { desc = "Ir a la declaración" })
        map("n", "gd", vim.lsp.buf.definition, { desc = "Ir a la definición" })
        map("n", "K", vim.lsp.buf.hover, { desc = "Mostrar documentación flotante" })
        map("n", "gi", vim.lsp.buf.implementation, { desc = "Ir a la implementación" })
        map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Renombrar símbolo" })
        map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Acciones de código" })
        map("n", "gr", vim.lsp.buf.references, { desc = "Mostrar referencias" })
        map("n", "[d", vim.diagnostic.goto_prev, { desc = "Diagnóstico anterior" })
        map("n", "]d", vim.diagnostic.goto_next, { desc = "Siguiente diagnóstico" })

        if client.supports_method("textDocument/formatting") then
          map("n", "<leader>f", function() vim.lsp.buf.format { async = true } end, { desc = "Formatear código" })
        end
      end

      -- Configuración para Lua
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })

      -- Configuración AVANZADA para Java (jdtls)
      lspconfig.jdtls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        -- La configuración de jdtls requiere una definición más detallada
        -- Ver: https://github.com/mfussenegger/nvim-jdtls
        cmd = { 'jdtls' },
        root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),
        -- Aquí es donde defines la configuración específica de Java
        -- Asegúrate de que JAVA_HOME esté configurado o que 'java' esté en tu PATH
        settings = {
          java = {
            signatureHelp = { enabled = true },
            contentProvider = { preferred = 'fernflower' },
            completion = {
              favoriteStaticMembers = {
                "org.hamcrest.MatcherAssert.assertThat",
                "org.hamcrest.Matchers.*",
                "org.junit.Assert.*",
              },
            },
            sources = {
              organizeImports = {
                starThreshold = 9999,
                staticStarThreshold = 9999,
              },
            },
            codeGeneration = {
              toString = {
                template = "${member.name()}=${member.value()}",
              },
              useBlocks = true,
            },
          }
        },
        -- Esta es la parte CLAVE para el soporte de depuración
        init_options = {
          bundles = {
            -- Habilita el adaptador de depuración de Java
            vim.fn.glob(vim.fn.stdpath('data') .. '/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar', 1)
          }
        }
      })
    end
  },
}
