local intervention = require("intervention")

vim.keymap.set("n", "<leader>t", function()
  if vim.bo.filetype == "netrw" then
    intervention.toggle_term({update_mark=false})
  else
    intervention.toggle_term()
  end
end)
vim.keymap.set("n", "<leader>q", function() intervention:recall() end)
