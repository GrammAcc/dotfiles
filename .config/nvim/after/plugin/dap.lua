local dap = require("dap")

local node_config = {
  {
    type = 'pwa-node',
    request = 'attach',
    name = 'Attach to Node Server',
    address = '127.0.0.1',
    port = 9229,
    cwd = '${workspaceFolder}',
  },
}

-- Haven't figured out how to get sourcemaps to work for typescript debugging yet.
dap.configurations.typescript = node_config

dap.configurations.javascript = node_config

dap.adapters['pwa-node'] = {
  type = 'server',
  host = '::1',
  port = '10101',
  executable = {
    command = "node",
    args = { "${HOME}/vscode-js-debug/src/dapDebugServer.js", "10101" },
  },
}

require("nvim-dap-virtual-text").setup({ commented = true })

local dapui = require("dapui")
dapui.setup()

vim.keymap.set("n", "<leader>do", dap.continue)
vim.keymap.set("n", "<leader>dy", dap.run_to_cursor)
vim.keymap.set("n", "<leader>dj", dap.step_into)
vim.keymap.set("n", "<leader>dk", dap.step_back)
vim.keymap.set("n", "<leader>dl", dap.step_over)
vim.keymap.set("n", "<leader>dh", dap.step_out)
vim.keymap.set("n", "<leader>dn", dap.toggle_breakpoint)
vim.keymap.set("n", "<leader>dp", dap.disconnect)

vim.keymap.set("n", "<F10>", dapui.toggle)
vim.keymap.set("n", "<leader>di", function() dapui.eval(nil, { enter = true }) end)

-- dap.listeners.before.attach.dapui_config = function()
--   dapui.open()
-- end
-- dap.listeners.before.event_terminated.dapui_config = function()
--   dapui.close()
-- end
