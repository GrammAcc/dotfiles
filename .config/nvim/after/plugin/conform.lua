local util = require("conform.util")

require("conform").setup({
  formatters = {
    isort = { prepend_args = { "--atomic", "" } },
    eslint = {
      command = util.from_node_modules("eslint"),
      args = { "--fix", "$FILENAME" },
      cwd = util.root_file({
        "package.json",
      }),
      stdin = false,
      exit_codes = { 0, 1 },
    },
  },
  formatters_by_ft = {
    lua = { "stylua", lsp_format = "fallback" },
    python = { "isort", "black", lsp_format = "never" },
    elixir = { "mix", lsp_format = "prefer" },
    javascript = {
      "eslint",
      "prettier",
      lsp_format = "never",
    },
    typescript = {
      "eslint",
      "prettier",
      lsp_format = "never",
    },
  },
})
