return {
  --'ThePrimeagen/harpoon',
  'GrammAcc/harpoon2-select-updates-index',
  branch = 'select-updates-index',
  dependencies = {"nvim-lua/plenary.nvim"},
  config = function()
    require("harpoon"):setup({
      settings = {
        save_on_toggle = true,
        sync_on_ui_close = true,
      }
    })
  end
}
