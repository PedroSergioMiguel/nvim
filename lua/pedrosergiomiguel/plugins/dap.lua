-- ~/.config/nvim/lua/pedrosergiomiguel/plugins/dap.lua

return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      -- Atajos de teclado para el depurador
      local map = vim.keymap.set
      map("n", "<leader>db", dap.toggle_breakpoint, { desc = "Añadir/Quitar breakpoint" })
      map("n", "<leader>dc", dap.continue, { desc = "Continuar ejecución" })
      map("n", "<leader>di", dap.step_into, { desc = "Entrar en función (Step Into)" })
      map("n", "<leader>do", dap.step_over, { desc = "Pasar por encima (Step Over)" })
      map("n", "<leader>dO", dap.step_out, { desc = "Salir de función (Step Out)" })
      map("n", "<leader>dr", dap.repl.open, { desc = "Abrir REPL" })
      map("n", "<leader>dl", dap.run_last, { desc = "Ejecutar última configuración" })
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio", -- Dependencia requerida por nvim-dap-ui
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup({
        layouts = {
          {
            elements = { "scopes", "breakpoints", "stacks", "watches" },
            size = 40,
            position = "left",
          },
          {
            elements = { "repl", "console" },
            size = 10,
            position = "bottom",
          },
        },
      })

      -- Listeners para abrir y cerrar automáticamente la interfaz de DAP
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- Atajo de teclado para la UI del depurador
      vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Abrir/Cerrar UI del depurador" })
    end,
  },
}
