local comment = require("Comment.api")

local esc_key = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)

vim.keymap.set("n", "<leader>n", comment.toggle.linewise.current)
vim.keymap.set("v", "<leader>n", function()
  vim.api.nvim_feedkeys(esc_key, 'x', false)
  comment.toggle.linewise(vim.fn.visualmode())
end)
