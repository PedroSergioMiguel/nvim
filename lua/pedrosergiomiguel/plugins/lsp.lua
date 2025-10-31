-- ~/.config/nvim/lua/pedrosergiomiguel/plugins/lsp.lua

return {
  -- Mason: para gestionar la instalación de LSPs, DAPs, linters, etc.
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  -- nvim-lspconfig: el motor principal para configurar los LSPs.
  { "neovim/nvim-lspconfig" },

  -- nvim-jdtls: herramientas específicas para el LSP de Java.
  { "mfussenegger/nvim-jdtls" },

  -- mason-lspconfig: el puente que conecta Mason (instaladores) con lspconfig (configurador).
  -- Este plugin orquesta la configuración y debe depender de los otros.
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "williamboman/mason.nvim",
      "mfussenegger/nvim-jdtls",
    },
    config = function()
      -- Define las capacidades que el cliente (Neovim) ofrece al servidor (LSP).
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Define la función que se ejecutará cada vez que un LSP se adjunte a un buffer.
      -- Aquí es donde se definen los atajos de teclado específicos del LSP.
      local on_attach = function(_, bufnr)
        local map = vim.keymap.set
        local opts = { noremap = true, silent = true, buffer = bufnr }

        map("n", "gD", vim.lsp.buf.declaration, { desc = "Ir a la declaración" })
        map("n", "gd", vim.lsp.buf.definition, { desc = "Ir a la definición" })
        map("n", "K", vim.lsp.buf.hover, { desc = "Mostrar documentación flotante" })
        map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Renombrar símbolo" })
        map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Acciones de código" })
      end

      -- Configura mason-lspconfig para que use "handlers" para cada servidor.
      -- Esta es la forma moderna y robusta de configurar los LSPs.
      require("mason-lspconfig").setup({
        ensure_installed = { "jdtls", "lua_ls" },
        handlers = {
          -- Handler por defecto para la mayoría de los servidores.
          function(server_name)
            require("lspconfig")[server_name].setup({
              on_attach = on_attach,
              capabilities = capabilities,
            })
          end,

          -- Handler específico y avanzado para Java (jdtls).
          ["jdtls"] = function()
            require("lspconfig").jdtls.setup({
              on_attach = on_attach,
              capabilities = capabilities,
              root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),
              -- Habilita el soporte para depuración (nvim-dap).
              init_options = {
                bundles = {
                  vim.fn.glob(vim.fn.stdpath('data') .. '/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar', 1)
                }
              }
            })
          end,
        },
      })
    end,
  },
}
