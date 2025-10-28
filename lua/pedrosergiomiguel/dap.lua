-- ~/.config/nvim/lua/pedrosergiomiguel/dap.lua

local dap = require("dap")
local dapui = require("dapui")

-- Atajos de teclado para el depurador
local map = vim.keymap.set
map("n", "<leader>db", dap.toggle_breakpoint, { desc = "Añadir/Quitar breakpoint" })
map("n", "<leader>dc", dap.continue, { desc = "Continuar ejecución" })
map("n", "<leader>di", dap.step_into, { desc = "Entrar en función (Step Into)" })
map("n", "<leader>do", dap.step_over, { desc = "Pasar por encima (Step Over)" })
map("n", "<leader>dO", dap.step_out, { desc = "Salir de función (Step Out)" })
map("n", "<leader>dr", dap.repl.open, { desc = "Abrir REPL" })
map("n", "<leader>dl", dap.run_last, { desc = "Ejecutar última configuración" })
map("n", "<leader>du", dap.ui.toggle, { desc = "Abrir/Cerrar UI del depurador" })

-- Configuración del adaptador de depuración para Java
-- nvim-jdtls se encarga de registrar el adaptador automáticamente,
-- por lo que solo necesitamos asegurarnos de que se configure correctamente
-- al iniciar. Esto es más bien una configuración para cuando se necesite
-- lanzar algo manualmente. La depuración de tests, por ejemplo,
-- se hará a través de las Code Actions del LSP.

-- El `README.md` explicará cómo crear un archivo `launch.json`
-- para configuraciones de depuración más complejas, como JBoss/Wildfly.

-- Integración con la UI
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

print("Configuración de DAP cargada.")
