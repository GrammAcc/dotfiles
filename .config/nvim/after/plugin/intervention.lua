local intervention = require("intervention")

vim.keymap.set("n", "<leader>t", function() intervention:toggle_term() end)
vim.keymap.set("n", "<leader>q", function() intervention:recall() end)
