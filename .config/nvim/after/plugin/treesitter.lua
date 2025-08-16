vim.opt.runtimepath:append("~/nvim-treesitter/parsers")

require("nvim-treesitter.configs").setup({
  parser_intsall_dir = "~/nvim-treesitter/parsers",
  ensure_installed = {
    "lua",
    "luadoc",
    "python",
    "sql",
    "toml",
    "vim",
    "vimdoc",
  },
  sync_install = false,
  auto_install = true,
  ignore_install = {},
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
})
