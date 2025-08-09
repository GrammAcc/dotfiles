-- Show line numbers by default.
vim.o.number = true

-- Prevent neovim from clobbering the terminal cursor settings.
-- See: https://github.com/neovim/neovim/issues/6005
vim.api.nvim_create_autocmd("ExitPre", {
	group = vim.api.nvim_create_augroup("Exit", { clear = true }),
	command = "set guicursor=a:ver90",
	desc = "Reset cursor back to terminal shape when leaving Neovim."
})

vim.api.nvim_create_autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup("Enter", { clear = true }),
  command = "clearjumps",
  desc = "Start vim with a clean jumplist",
})


