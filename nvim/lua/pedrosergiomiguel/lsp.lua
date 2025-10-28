-- ~/.config/nvim/lua/pedrosergiomiguel/lsp.lua

local lspconfig = require("lspconfig")
local mason_lspconfig = require("mason-lspconfig")

-- Mapeos de teclado para LSP
-- Estos atajos se activarán cuando un servidor de lenguaje se adjunte a un buffer
local on_attach = function(client, bufnr)
  local map = vim.keymap.set
  local opts = { noremap = true, silent = true, buffer = bufnr }

  map("n", "gD", vim.lsp.buf.declaration, opts)
  map("n", "gd", vim.lsp.buf.definition, opts)
  map("n", "K", vim.lsp.buf.hover, opts)
  map("n", "gi", vim.lsp.buf.implementation, opts)
  map("n", "<C-k>", vim.lsp.buf.signature_help, opts)
  map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
  map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
  map("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts)
  map("n", "<leader>D", vim.lsp.buf.type_definition, opts)
  map("n", "<leader>rn", vim.lsp.buf.rename, opts)
  map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  map("n", "gr", vim.lsp.buf.references, opts)
  map("n", "<leader>e", vim.diagnostic.open_float, opts)
  map("n", "[d", vim.diagnostic.goto_prev, opts)
  map("n", "]d", vim.diagnostic.goto_next, opts)
  map("n", "<leader>q", vim.diagnostic.setloclist, opts)

  -- Formatear al guardar, si el servidor lo soporta
  if client.supports_method("textDocument/formatting") then
    map("n", "<leader>f", function() vim.lsp.buf.format { async = true } end, opts)
  end
end

-- Configuración de los servidores de lenguaje
local servers = {
  "jdtls",
  "lua_ls",
}

mason_lspconfig.setup({
  ensure_installed = servers,
})

-- Configuración base para todos los servidores
local capabilities = require("cmp_nvim_lsp").default_capabilities()

for _, server in ipairs(servers) do
  if server == "jdtls" then
    -- La configuración específica de jdtls se manejará cuando se lance.
    -- Mason se encarga de la instalación y la configuración básica.
    -- Aquí solo nos aseguramos de que lspconfig lo conozca.
    lspconfig[server].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })
  elseif server == "lua_ls" then
     lspconfig[server].setup({
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
  else
    lspconfig[server].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })
  end
end

print("Configuración de LSP cargada.")
