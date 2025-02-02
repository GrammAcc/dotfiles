return {
  'nvim-telescope/telescope.nvim', branch = '0.1.x',
  dependencies = {'nvim-lua/plenary.nvim'},
  config = function ()
    require("telescope").setup({
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { height = 0.95, width = 0.95 },
      },
      pickers = {
        find_files = {
          hidden = true,
        }
      },
    })
  end
}
