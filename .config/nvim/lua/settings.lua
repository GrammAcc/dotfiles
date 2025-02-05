vim.o.number = true
vim.g.netrw_banner = 0

-- Prevent neovim from clobbering the terminal cursor settings.
-- See: https://github.com/neovim/neovim/issues/6005
vim.api.nvim_create_autocmd("ExitPre", {
	group = vim.api.nvim_create_augroup("Exit", { clear = true }),
	command = "set guicursor=a:ver90",
	desc = "Reset cursor back to terminal shape when leaving Neovim."
})
