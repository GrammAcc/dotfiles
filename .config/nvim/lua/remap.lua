local esc_key = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.keymap.set("n", "<leader>ll", "<C-W><C-L>")
vim.keymap.set("n", "<leader>kk", "<C-W><C-K>")
vim.keymap.set("n", "<leader>jj", "<C-W><C-J>")
vim.keymap.set("n", "<leader>hh", "<C-W><C-H>")
vim.keymap.set({ "n", "v" }, "<leader>i", ">>")
vim.keymap.set({ "n", "v" }, "<leader>u", "<<")
vim.keymap.set("n", "<F5>", ":checktime <CR>")
vim.keymap.set("v", "<leader>jq", ":!jq <CR>")
vim.keymap.set("n", "<C-j>", ":m+1 <CR>")
vim.keymap.set("n", "<C-k>", ":m-2 <CR>")
vim.keymap.set("v", "<C-j>", ":'<,'>m'>+1 <CR> gv")
vim.keymap.set("v", "<C-k>", ":'<,'>m'<-2 <CR> gv")
vim.keymap.set("n", "<C-CR>", "i <CR><Esc>")
vim.keymap.set("t", "<Esc>", "<C-\\><C-N>")
vim.keymap.set("v", "<leader>so", ":sort <CR>")

-- Find/Replace Inside Visual Block
vim.keymap.set("v", "<leader>r", function()
  vim.fn.inputsave()
  local find = vim.fn.input("Find:")
  vim.fn.inputrestore()
  vim.fn.inputsave()
  local replace = vim.fn.input("Replace:")
  vim.fn.inputrestore()
  local cm = "'<,'>s/" .. find .. "/" .. replace .. "/g"
  vim.api.nvim_feedkeys(esc_key, "x", false)
  vim.cmd(cm)
end)

vim.keymap.set("v", "<localleader>=", function()
  vim.api.nvim_feedkeys(esc_key, "x", false)
  vim.cmd("'<,'>s!^!>>> !")
end)
vim.keymap.set("v", "<localleader>-", function()
  vim.api.nvim_feedkeys(esc_key, "x", false)
  vim.cmd("'<,'>s!>>> !!")
end)

vim.keymap.set("v", "<localleader>]", function()
  vim.api.nvim_feedkeys(esc_key, "x", false)
  vim.cmd("'<,'>s/</\\&lt;/g")
  vim.cmd("'<,'>s/>/\\&gt;/g")
end)

vim.keymap.set("v", "<localleader>[", function()
  vim.api.nvim_feedkeys(esc_key, "x", false)
  vim.cmd("'<,'>s/\\&lt;/</g")
  vim.cmd("'<,'>s/\\&gt;/>/g")
end)
