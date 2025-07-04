local lspconfig = require("lspconfig")
local intervention = require("intervention")
local telescope = require("telescope.builtin")

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
    vim.keymap.set("n", "<leader>ls", function() telescope.lsp_document_symbols({ symbol_width = 60 }) end, opts)
    vim.keymap.set("n", "<leader>la", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>lf", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>ln", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("n", "<leader>lsh", function() vim.lsp.buf.signature_help() end, opts)
    vim.keymap.set("n", "<leader>lss", ":ClangdSwitchSourceHeader<CR>", opts)
    vim.keymap.set("n", "<leader>lrs", ":LspRestart <CR>", opts)
    vim.keymap.set("n", "<leader>lrq", ":LspStop <CR>", opts)
    vim.keymap.set("n", "<leader>lro", ":LspStart <CR>", opts)
    vim.keymap.set({"n","v"}, "<leader>lw", vim.lsp.buf.format)
  end,
})

local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
require("mason").setup({})
require("mason-lspconfig").setup({
  ensure_installed = {
    "clangd",
    "cssls",
    "html",
    "jdtls",
    "jsonls",
    "lemminx",
    "lexical",
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
      local exclude = {
        eslint = true,
        nextls = true,
        elixirls = false,
        lexical = true,
      }
      if not exclude[server_name] then
        lspconfig[server_name].setup({
          capabilities = lsp_capabilities,
        })
      end
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

-- Javascript/Typescript lsp config
-- Common settings for JS and TS
local ts_ls_settings = { preferences = { importModuleSpecifier = "project-relative" } }

lspconfig.ts_ls.setup({
  capabilities = lsp_capabilities,
  javascript = ts_ls_settings,
  typescript = ts_ls_settings,
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
