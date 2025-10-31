-- ~/.config/nvim/lua/pedrosergiomiguel/plugins/dap.lua

return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- Configurar la interfaz de usuario del depurador (DAP UI)
      dapui.setup({
        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.25 },
              { id = "breakpoints", size = 0.25 },
              { id = "stacks", size = 0.25 },
              { id = "watches", size = 0.25 },
            },
            size = 40,
            position = "left",
          },
          {
            elements = {
              { id = "repl", size = 0.5 },
              { id = "console", size = 0.5 },
            },
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

      -- Atajos de teclado para el depurador
      local map = vim.keymap.set
      map("n", "<leader>db", dap.toggle_breakpoint, { desc = "Añadir/Quitar breakpoint" })
      map("n", "<leader>dc", dap.continue, { desc = "Continuar ejecución" })
      map("n", "<leader>di", dap.step_into, { desc = "Entrar en función (Step Into)" })
      map("n", "<leader>do", dap.step_over, { desc = "Pasar por encima (Step Over)" })
      map("n", "<leader>dO", dap.step_out, { desc = "Salir de función (Step Out)" })
      map("n", "<leader>dr", dap.repl.open, { desc = "Abrir REPL" })
      map("n", "<leader>dl", dap.run_last, { desc = "Ejecutar última configuración" })
      map("n", "<leader>du", dapui.toggle, { desc = "Abrir/Cerrar UI del depurador" })
    end,
  },
}
