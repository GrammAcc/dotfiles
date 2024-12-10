local lspconfig = require("lspconfig")
local intervention = require("intervention")

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("user_lsp_attach", { clear = true }),
  callback = function(event)
    local opts = { buffer = event.buf }
    vim.keymap.set("n", "<leader>lg", function()
      intervention:mark()
      vim.lsp.buf.definition()
    end, opts)
    vim.keymap.set("n", "<leader>lk", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>lee", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "<leader>lei", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "<leader>leu", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>ls", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>la", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>lf", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>ln", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("n", "<leader>lsg", function() vim.lsp.buf.signature_help() end, opts)
    vim.keymap.set("n", "<leader>lss", ":ClangdSwitchSourceHeader<CR>", opts)
    vim.keymap.set("n", "<leader>lrs", ":LspRestart <CR>", opts)
    vim.keymap.set({ "n", "v" }, "<leader>lw", function()
      local ft = vim.bo.filetype
      if ft == "javascript" or ft == "typescript" or ft == "html" then
        local enter_key = vim.api.nvim_replace_termcodes("<CR>", true, false, true)
        vim.cmd("!npx prettier --write %")
        vim.api.nvim_feedkeys(enter_key, "n", false)
      else
        vim.lsp.buf.format()
      end
    end, opts)
  end,
})


local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
require("mason").setup({})
require("mason-lspconfig").setup({
  ensure_installed = {
    "clangd",
    "cssls",
    "eslint",
    "html",
    "jdtls",
    "jsonls",
    "lemminx",
    "ltex",
    "lua_ls",
    "marksman",
    "prismals",
    "sqlls",
    "taplo",
    "ts_ls",
    "vuels",
    "yamlls",
  },
  handlers = {
    function(server_name)
      lspconfig[server_name].setup({
        capabilities = lsp_capabilities,
      })
    end,
  },
})

-- Lua lsp config.
lspconfig.lua_ls.setup({
  capabilities = lsp_capabilities,
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT"
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          vim.env.VIMRUNTIME,
        }
      }
    }
  }
})

-- Elixir lsp config.
lspconfig.elixirls.setup({
  cmd = { vim.fn.expand("~/elixir-ls/language_server.sh") },
  capabilities = lsp_capabilities,
  settings = {
    elixirLS = {
      -- elixirls correctly sets this variable at runtime, but
      -- it still uses the default "test" env for finding deps, so
      -- things like formatting libraries will need to be added to the
      -- deps for the :test env in the Mix.exs. In practice, this
      -- shouldn't be an issue since it's still not prod, but it's
      -- really annoying.
      -- I need to dig into the elixir lsp more to understand what I'm doing wrong here.
      mixEnv = "dev",
      dialyzerEnabled = false,
      fetchDeps = false,
    },
  },
})


-- Python lsp config
local venv_path = os.getenv("VIRTUAL_ENV")
local py_path = nil
local mypy_enabled = false
-- Decide which python executable to use for mypy.
-- This is necessary to get correct type checking of packages installed in venv.
if venv_path ~= nil then
  py_path = venv_path .. "/bin/python3"
  mypy_enabled = true
else
  py_path = vim.g.python3_host_prog
end

-- Configure pylsp plugins.
lspconfig.pylsp.setup({
  capabilities = lsp_capabilities,
  settings = {
    pylsp = {
      configurationSources = { "flake8" },
      plugins = {
        jedi_completion = {
          enabled = true,
          include_params = false,
          include_class_objects = false,
          include_function_objects = false,
          fuzzy = false,
          eager = true,
        },
        jedi_definition = { enabled = true },
        jedi_hover = { enabled = true },
        jedi_references = { enabled = true },
        jedi_signature_help = { enabled = true },
        jedi_symbols = { enabled = true, all_scopes = true },
        flake8 = { enabled = true },
        isort = { enabled = true },
        black = { enabled = true },
        pylsp_mypy = { enabled = mypy_enabled, overrides = { "--python-executable", py_path, true } },
        pyflakes = { enabled = false },
        pycodestyle = { enabled = false },
        yapf = { enabled = false },
        pylint = { enabled = false },
        pydocstyle = { enabled = false },
        mccabe = { enabled = false },
        preload = { enabled = false },
        rope_completion = { enabled = false }
      }
    }
  },
})

-- GDScript lsp config
-- Even though this uses the default setup, it has to be after the dynamic
-- Mason setup above or the client won't attach. I don't know why.
lspconfig.gdscript.setup({ capabilities = lsp_capabilities })


local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
  sources = {
    { name = "path" },
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
    ["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
    ["<enter>"] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
  }),
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
})
