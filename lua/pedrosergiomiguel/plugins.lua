-- ~/.config/nvim/lua/pedrosergiomiguel/plugins.lua

-- Este archivo define todos los plugins gestionados por lazy.nvim

return {
  -- Tema y UI
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        style = "night", -- Opciones: "storm", "night", "day"
        on_colors = function(colors)
          -- Personalización de colores si es necesario
        end,
      })
      vim.cmd.colorscheme("tokyonight")
      print("Tema tokyonight cargado.")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "tokyonight",
          component_separators = { left = '', right = ''},
          section_separators = { left = '', right = ''},
        },
        sections = {
          lualine_c = { "filename" },
          lualine_x = { "encoding", "fileformat", "filetype" },
        }
      })
      print("Lualine cargado.")
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- Nerd-Fonts are required
      "MunifTanjim/nui.nvim",
    },
    config = function ()
      vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { desc = "Abrir/Cerrar explorador de archivos" })
      require("neo-tree").setup({
        window = {
          position = "left",
          width = 30,
        },
      })
      print("Neo-tree cargado.")
    end
  },
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("bufferline").setup({
        options = {
          mode = "tabs",
          separator_style = "thin",
          show_buffer_close_icons = true,
          show_close_icon = true,
          diagnostics = "nvim_lsp",
          diagnostics_indicator = function(count, level, _, _)
            local icon = level:match("error") and " " or " "
            return " " .. icon .. count
          end,
        },
      })
      -- Atajos para navegar entre pestañas/buffers
      local map = vim.keymap.set
      map("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Siguiente buffer" })
      map("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Buffer anterior" })
      print("Bufferline cargado.")
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("ibl").setup({
        indent = {
          char = "│",
          tab_char = "│",
        },
        scope = { enabled = false },
      })
      print("Indent-blankline cargado.")
    end,
  },

  -- Utilidades de desarrollo
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end
  },
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

  -- LSP (Language Server Protocol)
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim", "neovim/nvim-lspconfig" },
  },
  {
    "neovim/nvim-lspconfig",
    config = function ()
      -- Este es el punto de entrada para la configuración del LSP.
      -- La configuración específica de Java se hará en lsp.lua
      require("pedrosergiomiguel.lsp")
    end
  },

  -- DAP (Debug Adapter Protocol)
  {
    "mfussenegger/nvim-dap",
    config = function()
      -- La configuración de DAP se hará en dap.lua
      require("pedrosergiomiguel.dap")
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {"mfussenegger/nvim-dap"},
    config = function ()
      require("dapui").setup()
    end
  },
}
