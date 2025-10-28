-- ~/.config/nvim/lua/pedrosergiomiguel/dap.lua

local dap = require("dap")
local dapui = require("dapui")

-- SETUP DAP UI
dapui.setup()

-- DAP KEYBINDINGS
local keymap = vim.keymap.set
keymap("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
keymap("n", "<leader>dc", dap.continue, { desc = "Continue" })
keymap("n", "<leader>di", dap.step_into, { desc = "Step Into" })
keymap("n", "<leader>do", dap.step_over, { desc = "Step Over" })
keymap("n", "<leader>dO", dap.step_out, { desc = "Step Out" })
keymap("n", "<leader>dr", dap.repl.open, { desc = "Open REPL" })
keymap("n", "<leader>dl", dap.run_last, { desc = "Run Last" })

-- Open/Close DAP UI when debugging
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

-- JAVA DEBUG ADAPTER CONFIGURATION
-- This requires the nvim-jdtls plugin to have been configured correctly.
-- jdtls will automatically download the necessary debug adapters.
-- We need to hook into the jdtls startup to configure the Java debugger.
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.name == "jdtls" then
      -- The jdtls plugin provides this helper function to bootstrap the debugger
      require("jdtls").setup_dap({ hotcodereplace = "auto" })
    end
  end,
})

-- The configuration for launching Maven/JBoss/WildFly projects
-- is typically done via a .vscode/launch.json file in the project root
-- or can be configured programmatically here if preferred.
require("dap.ext.vscode").load_launchjs()
