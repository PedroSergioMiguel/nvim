-- ~/.config/nvim/lua/pedrosergiomiguel/lsp.lua

-- MASON.NVIM SETUP
-- Mason se encarga de instalar los LSPs, DAP, linters, etc.
require("mason").setup()

-- NVIM-CMP SETUP (AUTOCOMPLETION)
local cmp = require("cmp")
local cmp_lsp = require("cmp_nvim_lsp")
local luasnip = require("luasnip")

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }, {
    { name = "buffer" },
    { name = "path" },
  }),
})

-- CAPABILITIES
-- Esto le dice al servidor LSP que capacidades tiene el cliente (nvim-cmp)
local capabilities = cmp_lsp.default_capabilities()

-- LSP KEYBINDINGS (se adjuntaran a cada servidor)
local on_attach = function(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }
  local keymap = vim.keymap.set

  keymap("n", "gD", vim.lsp.buf.declaration, opts)
  keymap("n", "gd", vim.lsp.buf.definition, opts)
  keymap("n", "K", vim.lsp.buf.hover, opts)
  keymap("n", "gi", vim.lsp.buf.implementation, opts)
  keymap("n", "<C-k>", vim.lsp.buf.signature_help, opts)
  keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)
  keymap("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  keymap("n", "gr", vim.lsp.buf.references, opts)
  keymap("n", "<leader>de", vim.diagnostic.open_float, opts)
  keymap("n", "[d", vim.diagnostic.goto_prev, opts)
  keymap("n", "]d", vim.diagnostic.goto_next, opts)
end

-- MASON-LSPCONFIG SETUP
-- Este plugin es el puente entre Mason (instalador) y lspconfig (configurador)
require("mason-lspconfig").setup({
  ensure_installed = { "jdtls" }, -- Asegura que jdtls este instalado
  handlers = {
    -- La configuracion por defecto para todos los LSPs
    function(server_name)
      require("lspconfig")[server_name].setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })
    end,

    -- Configuracion especifica para Java (jdtls)
    ["jdtls"] = function()
      require("lspconfig").jdtls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" }),
        -- Aqui se pueden anadir mas configuraciones especificas de jdtls si es necesario
      })
    end,
  },
})
