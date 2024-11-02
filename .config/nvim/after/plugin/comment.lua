local comment = require("Comment.api")

vim.keymap.set("n", "<leader>n", function() comment.toggle.linewise() end)

-- For some reason, the visual mode doesn't work unless we use lua via vimscript command.
vim.keymap.set("v", "<leader>n", ":lua require('Comment.api').toggle.linewise('visual') <CR>")
