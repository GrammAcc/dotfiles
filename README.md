# Neovim Python Setup

This branch contains a python-specific neovim config for quickly bootstrapping a new install of neovim for Python development.

## Setup

To setup the editor, just run `bash gramms_automagical_neovim_as_a_python_dev_env_install_script.sh` from the root of this repo.

This script builds neovim from source and installs the [python-lsp-server](https://github.com/python-lsp/python-lsp-server) using [pipx](https://github.com/pypa/pipx). It should work on linux and mac.

To ensure the script runs successfully, make sure clang, cmake, and pipx are all installed and available on your PATH.

Neovim requires clang (or gcc) and cmake to build, and pipx is needed to setup python-lsp-server and its plugins correctly.

The script will clone neovim and build specifically version 0.11.2 from source. The built binary will be installed to `~/neovim`, so you will need to add that directory to your PATH. For example: `export PATH="$PATH:~/neovim/bin"` in your .bashrc or `path=(~/neovim/bin $path[@])` in your .zshrc.

Once the script has finished running and your PATH has been updated,  open any file or directory with neovim e.g. `nvim app.py`. You should see a black screen. This first startup will be slow since the init.lua has to clone and install lazy.nvim. Wait a few moments and you should see the Lazy UI open on the screen and start installing all of the plugins for the LSP integration and syntax highlighting. Once Lazy and Treesitter have finished installing everything, you can start editing your Python right away.

To check that everything installed correctly, run `:LspInfo` from inside a `.py` file. You should see the python lsp client attached to the buffer.

## Preconfigured Keybinds

The config in this branch is intentionally very minimal, but it includes a handful of keymaps related to lsp and basic navigation.
I like namespacing related plugin commands, so the lsp commands all start with the <leader>l combination.
The leader key is set to spacebar in this config.

- Navigation:
  - <leader>t: toggle terminal (fullscreen)
  - <leader>dd: toggle file browser (fullscreen netrw)
- LSP Commands:
  - <leader>lg: goto definition
  - <leader>lw: format current file
  - <leader>lf: find references
  - <leader>ln: rename symbol
  - <leader>lk: hover symbol info
  - <leader>lee: open diagnostics (linter/type error info)
  - <leader>ls: symbol browser
  - <leader>la: code actions (depends on plugin support)
- Search (telescope):
  - <leader>fl: fuzzy find files
  - <leader>fk: fuzzy find git files (current repo)
  - <leader>fj: grep file contents
  - <leader>f;: search file contents for the word underneath the cursor
  - <leader>fo: open telescope menu for all search plugins

## A note about mypy

The pylsp config in this repo uses the mypy plugin to allow for type errors to show up in-editor as you code, but there are two major problems with the mypy plugin for pylsp:

1. It slows down the editor.
  - This might not be a deal breaker if you're used to IDEs, but if you're used to the snappiness of vim, this will drive you insane.
2. Mypy's type checking depends on the python version it's running against.
  - For example, the syntax `type MyInt = int` is valid in Python 3.12, but not in Python 3.11.
  - This is problematic for an editor plugin since a project might be targeting Python 3.11, but your global Python might be 3.12, so the editory plugin needs to somehow run on the same Python you are targeting in the current project, not the system Python.

The way that I solve this is to assign the Python interpreter that the mypy plugin uses in the config explicitly when it is running inside a virtual environment. The assumption is that the virtual environment will represent the target environment for the project. I learned this trick from a blog post I found a while back, but I can't find the original post, and I don't remember who wrote it, so I can't give proper credit for this workaround.

In addition to using the Python version from the virtual environment, I also only enable the mypy plugin when neovim is started from inside a virtual environment. This gives an easy way to enable the plugin ad-hoc with the correct Python version when I want to see errors as I type, but keep my editor snappy when I don't need it.
