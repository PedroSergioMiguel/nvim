-- ~/.config/nvim/lua/pedrosergiomiguel/plugins/tools.lua

return {
  -- Git
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy", -- Cargar de forma perezosa para evitar conflictos
    config = function()
      require("gitsigns").setup()
    end
  },
  {
    "kdheepak/lazygit.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      vim.keymap.set("n", "<leader>lg", ":LazyGit<CR>", { desc = "Abrir Lazygit" })
    end
  },

  -- Búsqueda (Search)
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function ()
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Buscar archivos" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Buscar texto en proyecto" })
    end
  },

  -- Resaltado de sintaxis (Syntax Highlighting)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function ()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "java" },
        sync_install = false,
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      }
    end
  },

  -- Asistencia de IA (AI Assistance)
  {
    "github/copilot.vim",
    -- No requiere configuración inicial, pero se puede añadir si es necesario.
    -- El usuario deberá autenticarse la primera vez que lo use.
  },
}
