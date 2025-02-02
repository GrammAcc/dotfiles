local telescope = require("telescope.builtin")

vim.keymap.set("n", "<leader>fk", telescope.git_files)
vim.keymap.set("n", "<leader>fj", telescope.find_files)
vim.keymap.set("n", "<leader>fl", telescope.live_grep)
vim.keymap.set("n", "<leader>f;", telescope.grep_string)
vim.keymap.set("n", "<leader>fo", ":Telescope<CR>")
