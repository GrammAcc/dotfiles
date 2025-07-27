local helpers = require("helpers")

local esc_key = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local function paste_from_buffer(register)
  vim.cmd(':normal "' .. register .. "p")
end

vim.keymap.set({ "n", "v" }, "<leader>i", ">>")
vim.keymap.set({ "n", "v" }, "<leader>u", "<<")
vim.keymap.set("n", "<F5>", ":checktime <CR>")
vim.keymap.set("v", "<leader>jq", ":!jq <CR>")
vim.keymap.set("n", "<C-j>", ":m+1 <CR>")
vim.keymap.set("n", "<C-k>", ":m-2 <CR>")
vim.keymap.set("v", "<C-j>", ":'<,'>m'>+1 <CR> gv")
vim.keymap.set("v", "<C-k>", ":'<,'>m'<-2 <CR> gv")
vim.keymap.set("t", "<Esc>", "<C-\\><C-N>")
vim.keymap.set("v", "<leader>so", ":sort <CR>")
vim.keymap.set("n", "<leader>sn", ":set number! <CR>")
vim.keymap.set("n", "<leader>co", ":copen <CR>")
vim.keymap.set("n", "<leader>ci", ":cclose <CR>")
vim.keymap.set("n", "<leader>ff", function()
  vim.fn.setreg("+", vim.fn.expand("%"))
  paste_from_buffer("+")
end)

-- Run current line as a commandline in the shell and print the output
-- to the line below the current line.
vim.keymap.set("n", "<leader>cc", function()
  local cmd = vim.api.nvim_get_current_line()
  local file = assert(io.popen(cmd .. " 2>&1", "r"), "Error executing command " .. cmd)
  file:flush()
  local res = file:read("a")
  file:close()

  vim.fn.setreg("c", res)
  paste_from_buffer("c")
end)

-- Find/Replace Inside Visual Block
vim.keymap.set("v", "<leader>r", function()
  vim.fn.inputsave()
  local find = vim.fn.input("Find:")
  vim.fn.inputrestore()
  vim.fn.inputsave()
  local replace = vim.fn.input("Replace:")
  vim.fn.inputrestore()
  local cm = "'<,'>s/" .. find .. "/" .. replace .. "/g"
  vim.api.nvim_feedkeys(esc_key, "x", false)
  vim.cmd(cm)
end)

vim.keymap.set("v", "<localleader>=", function()
  vim.api.nvim_feedkeys(esc_key, "x", false)
  vim.cmd("'<,'>s!^!>>> !")
end)
vim.keymap.set("v", "<localleader>-", function()
  vim.api.nvim_feedkeys(esc_key, "x", false)
  vim.cmd("'<,'>s!>>> !!")
end)

vim.keymap.set("v", "<localleader>]", function()
  vim.api.nvim_feedkeys(esc_key, "x", false)
  vim.cmd("'<,'>s/</\\&lt;/g")
  vim.cmd("'<,'>s/>/\\&gt;/g")
end)

vim.keymap.set("v", "<localleader>[", function()
  vim.api.nvim_feedkeys(esc_key, "x", false)
  vim.cmd("'<,'>s/\\&lt;/</g")
  vim.cmd("'<,'>s/\\&gt;/>/g")
end)


local get_word_under_cursor = function() return vim.fn.escape(vim.fn.expand('<cword>'), [[\/]]) end

local function swap_words(dir)
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  local cursor_word = get_word_under_cursor()
  local cur_line = vim.api.nvim_get_current_line()
  local terminators = { ")", "}", "]" }
  local find_block = function()
    local first_idx = 9999
    local first_char = nil

    for _, char in ipairs(terminators) do
      local found = string.find(cur_line, char)
      if found ~= nil then
        if found < first_idx then
          first_idx = found
          first_char = char
        end
      end
    end
    return first_char
  end

  local block_char = find_block()

  if block_char == nil then
    -- No list block on the current line.
    vim.api.nvim_win_set_cursor(0, cursor_pos)
    return
  end

  local find_word = function(word_list)
    for idx, word in ipairs(word_list) do
      local found = string.find(word, cursor_word)
      if found ~= nil then
        return idx
      end
    end
    return nil
  end

  -- Read target words into s register.
  vim.cmd(":silent normal " .. '"' .. "syi" .. block_char)
  local selection = vim.fn.getreg("s")
  local words = helpers.split(selection, ", ")
  if (#words == 1) then
    -- Nothing to swap.
    vim.api.nvim_win_set_cursor(0, cursor_pos)
    return
  end
  local target_idx = find_word(words)
  if target_idx == nil then
    -- Not inside a list block.
    vim.api.nvim_win_set_cursor(0, cursor_pos)
    return
  end
  -- assert(target_idx, "Cursor was not inside a block")
  if dir == "rtl" then
    helpers.swap(words, target_idx, target_idx - 1)
  else
    helpers.swap(words, target_idx, target_idx + 1)
  end
  local output = table.concat(words, ", ")
  vim.fn.setreg("s", output)
  vim.cmd(":silent normal vi" .. block_char)
  vim.cmd(":silent normal " .. '"' .. "sp")
  vim.api.nvim_win_set_cursor(0, cursor_pos)
end

vim.keymap.set("n", "<leader>sl", function() swap_words("ltr") end)
vim.keymap.set("n", "<leader>sh", function() swap_words("rtl") end)
