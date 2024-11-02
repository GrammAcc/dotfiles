local telescope = require("telescope.builtin")
vim.keymap.set("n", "<leader>pd", telescope.git_files)
vim.keymap.set("n", "<leader>pf", telescope.find_files)
vim.keymap.set("n", "<leader>ps", telescope.live_grep)
vim.keymap.set("n", "<leader>ph", function()
  telescope.grep_string({ search = vim.fn.input("Grep > ") })
end)