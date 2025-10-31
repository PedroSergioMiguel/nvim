-- ~/.config/nvim/lua/pedrosergiomiguel/plugins/ui.lua

-- Este archivo define los plugins relacionados con la interfaz de usuario

return {
  -- Tema (Theme)
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        style = "night", -- Opciones: "storm", "night", "day"
        on_colors = function(colors)
          -- Aquí se pueden personalizar los colores si es necesario
          colors.comment = "#6a737d" -- Un gris más suave para los comentarios
        end,
      })
      vim.cmd.colorscheme("tokyonight")
    end,
  },

  -- Línea de estado (Status Line)
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "tokyonight",
          component_separators = { left = '', right = ''},
          section_separators = { left = '', right = ''},
          icons_enabled = true,
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {'branch', 'diff', 'diagnostics'},
          lualine_c = {'filename'},
          lualine_x = {'encoding', 'fileformat', 'filetype'},
          lualine_y = {'progress'},
          lualine_z = {'location'}
        },
      })
    end,
  },

  -- Explorador de archivos (File Explorer)
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- Necesario para los iconos
      "MunifTanjim/nui.nvim",
    },
    config = function ()
      vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { desc = "Abrir/Cerrar explorador de archivos" })
      require("neo-tree").setup({
        window = {
          position = "left",
          width = 30,
        },
        filesystem = {
          filtered_items = {
            visible = true,
            hide_dotfiles = false,
            hide_gitignored = true,
          }
        }
      })
    end
  },

  -- Barra de pestañas (Buffer Tabs)
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
    end,
  },

  -- Líneas de indentación (Indent Lines)
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
    end,
  },
}
