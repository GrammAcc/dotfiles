vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 0
vim.g.netrw_altfile = 1
vim.g.netrw_fastbrowse = 0


-- Prevent netrw from polluting the jump list.
-- The key part is the bufhidden='wipe', which causes netrw
-- buffers to be cleared from the metadata stores when they are
-- hidden.
-- This only works if the netrw_fastbrowse = 0 setting above
-- is also set because otherwise, netrw will keep its own buffers
-- around to keep track of the directory cache.
vim.api.nvim_create_augroup('netrw', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  group = 'netrw',
  pattern = 'netrw',
  callback = function()
    vim.api.nvim_command('setlocal buftype=nofile')
    vim.api.nvim_command('setlocal bufhidden=wipe')
  end
})


vim.keymap.set("n", "<leader>dd", function()
  if vim.bo.filetype == "netrw" then
    vim.api.nvim_command("Rex")
  else
    vim.api.nvim_command("Ex")
  end
end)
