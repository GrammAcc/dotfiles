local harpoon = require("harpoon")

local opts = { ui_nav_wrap = true }

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<leader>o", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
vim.keymap.set("n", "<C-0>", function() harpoon:list():next(opts) end)
vim.keymap.set("n", "<C-9>", function() harpoon:list():prev(opts) end)
