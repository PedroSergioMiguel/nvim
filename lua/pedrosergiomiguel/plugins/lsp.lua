-- ~/.config/nvim/lua/pedrosergiomiguel/plugins/lsp.lua

return {
  -- Mason: para gestionar la instalación de LSPs.
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  -- Motores principales del LSP
  { "neovim/nvim-lspconfig" },
  { "mfussenegger/nvim-jdtls" },

  -- Puente entre Mason (instalador) y lspconfig (configurador)
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "neovim/nvim-lspconfig", "williamboman/mason.nvim" },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local on_attach = function(_, bufnr)
        local map = vim.keymap.set
        local opts = { noremap = true, silent = true, buffer = bufnr }
        map("n", "gd", vim.lsp.buf.definition, { desc = "Ir a la definición" })
        map("n", "K", vim.lsp.buf.hover, { desc = "Mostrar documentación" })
        map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Acciones de código" })
        map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Renombrar" })
      end

      require("mason-lspconfig").setup({
        ensure_installed = { "jdtls", "lua_ls" },
        handlers = {
          -- HANDLER POR DEFECTO: La solución final está aquí.
          -- Este código se ejecuta para CADA servidor que Mason encuentra.
          function(server_name)
            local lspconfig = require("lspconfig")
            -- COMPROBACIÓN CLAVE: Solo intentar configurar el servidor si 'lspconfig'
            -- realmente tiene una configuración para él. Esto evita el error.
            if lspconfig[server_name] then
              lspconfig[server_name].setup({
                on_attach = on_attach,
                capabilities = capabilities,
              })
            end
          end,

          -- HANDLER PARA JAVA (jdtls): Requiere una configuración especial.
          ["jdtls"] = function()
            require("lspconfig").jdtls.setup({
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
      })
    end,
  },
}
