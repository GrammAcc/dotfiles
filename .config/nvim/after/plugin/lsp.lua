local intervention = require("intervention")
local telescope = require("telescope.builtin")

local lsps_to_enable = {
  "clangd",
  "cssls",
  "elixirls",
  -- "expert",
  "gdscript",
  "html",
  "jsonls",
  -- "lexical",
  "lua_ls",
  "marksman",
  "pylsp",
  "sqlls",
  "taplo",
  "ts_ls",
  "yamlls",
}

-- Don't preselect. Avoids accidental completion.
vim.opt.completeopt = { "menu", "menuone", "noselect" }

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("user_lsp_attach", { clear = true }),
  callback = function(event)
    local client = assert(vim.lsp.get_client_by_id(event.data.client_id))
    -- Trigger autocompletion on every keypress.
    local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
    client.server_capabilities.completionProvider.triggerCharacters = chars

    vim.lsp.completion.enable(true, client.id, event.buf, {
      autotrigger = true,
    })

    -- Remap the built-in popup menu navigation to CTRL+j/CTRL+k to prevent needing to
    -- spend half my salary on physical therapy for hand injuries.
    -- Also use Tab for selecting first option quickly.
    vim.cmd("inoremap <expr><Tab> pumvisible() ? '<C-n>' : '<Tab>'")
    vim.cmd("inoremap <expr><C-j> pumvisible() ? '<C-n>' : '<C-j>'")
    vim.cmd("inoremap <expr><C-k> pumvisible() ? '<C-p>' : '<C-k>'")

    -- Remap the built-in gr* mappings since they require hitting both keys with the left hand, and
    -- can't be rolled like an `lk` kind of binding. They also require reaching to start the
    -- sequence since the g key isn't one of the resting keys.
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
    vim.keymap.set({ "n", "v" }, "<leader>lw", function()
      local prettier_filetypes = {
        typescript = true,
        javascript = true,
        html = false,
      }

      if prettier_filetypes[vim.bo.filetype] then
        local enter_key = vim.api.nvim_replace_termcodes("<CR>", true, false, true)
        vim.cmd("!npx prettier --write %")
        vim.api.nvim_feedkeys(enter_key, "n", false)
      else
        vim.lsp.buf.format()
      end
    end)
  end,
})

require("mason").setup()

-- Lua
vim.lsp.config("lua_ls", {
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


-- Elixir

-- Setup for all three elixir lsps are included here since they all break intermittently, but one of them will usually work.
-- Eventually, expert should become stable, but for now, we have to play whack-a-server with the rotating crash conditions.

-- vim.lsp.config('expert', {
--   cmd = { 'expert', '--stdio' },
--   root_markers = { 'mix.exs', '.git' },
--   filetypes = { 'elixir', 'eelixir', 'heex' },
-- })

-- vim.lsp.config('lexical', {
--   cmd = { 'lexical' },
--   root_markers = { 'mix.exs', '.git' },
--   filetypes = { 'elixir', 'eelixir', 'heex' },
-- })

vim.lsp.config('elixirls', {
  cmd = { 'elixir-ls' },
  root_markers = { 'mix.exs', '.git' },
  filetypes = { 'elixir', 'eelixir', 'heex' },
})


-- Python
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
vim.lsp.config("pylsp", {
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
          eager = false,
        },
        jedi_definition = { enabled = true },
        jedi_hover = { enabled = true },
        jedi_references = { enabled = true },
        jedi_signature_help = { enabled = false },
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
        rope_autoimport = { enabled = false },
        rope_completion = { enabled = false }
      }
    }
  },
})


-- Javascript/Typescript
vim.lsp.config("ts_ls", {
  typescript = { preferences = { importModuleSpecifierPreference = "project-relative" } },
  javascript = { preferences = { importModuleSpecifierPreference = "project-relative" } },
})


for _, server_name in ipairs(lsps_to_enable) do
  vim.lsp.enable(server_name)
end
