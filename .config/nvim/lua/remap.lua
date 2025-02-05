local esc_key = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

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
vim.keymap.set("n", "<leader>sn", ":set number! <CR>")
vim.keymap.set("n", "<leader>co", ":copen <CR>")
vim.keymap.set("n", "<leader>ci", ":cclose <CR>")
vim.keymap.set("n", "<leader>dd", ":Explore <CR>")

local function paste_from_buffer(register)
  vim.cmd(':normal "' .. register .. "p")
end

vim.keymap.set("n", "<leader>ff", function()
  vim.fn.setreg("+", vim.fn.expand("%"))
  paste_from_buffer("+")
end)

-- Run current line as a commandline in the shell and print the output
-- to the line below the current line.
vim.keymap.set("n", "<leader>cc", function()
  local cmd = vim.api.nvim_get_current_line()
  local file = assert(io.popen(cmd .. " 2>&1", "r"), "Error executing command " .. cmd)
  file:flush()
  local res = file:read("a")
  file:close()

  vim.fn.setreg("c", res)
  paste_from_buffer("c")
end)

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
