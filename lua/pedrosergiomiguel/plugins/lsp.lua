-- ~/.config/nvim/lua/pedrosergiomiguel/plugins/lsp.lua

return {
  -- Mason: Instala los LSPs, DAPs, etc.
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  -- Mason-LSPConfig: Se asegura de que los servidores de lenguaje estén instalados.
  -- NO se usa para la configuración, solo para la instalación.
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "jdtls", "lua_ls" },
        -- IMPORTANTE: No se usa la tabla 'handlers'. Se desactiva la configuración automática.
      })
    end,
  },

  -- nvim-lspconfig: El motor que REALMENTE configura los servidores.
  -- Esta es la configuración explícita que evita el error.
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "mfussenegger/nvim-jdtls",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Función on_attach: Se ejecuta cuando un LSP se adjunta a un buffer.
      local on_attach = function(_, bufnr)
        local map = vim.keymap.set
        local opts = { noremap = true, silent = true, buffer = bufnr }
        map("n", "gd", vim.lsp.buf.definition, { desc = "Ir a la definición" })
        map("n", "K", vim.lsp.buf.hover, { desc = "Mostrar documentación" })
        map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Acciones de código" })
      end

      -- Configuración explícita para Lua
      lspconfig.lua_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
          },
        },
      })

      -- Configuración explícita y avanzada para Java (jdtls)
      lspconfig.jdtls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),
        init_options = {
          bundles = {
            vim.fn.glob(vim.fn.stdpath('data') .. '/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar', 1)
          }
        }
      })
    end,
  },
}
