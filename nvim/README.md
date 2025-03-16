<<<<<<< Updated upstream

# A Basic Stable IDE config for Neovim

> Why does this repo exist?

This config attempts to provide a rock solid fully featured starting point for someone new to Neovim, or just tired of maintaining the basic IDE components of their config.

> What makes it "rock solid"?

All of the included plugins are pinned to a version that ensures they are compatible and will not update potentially introducing errors into your config. For every Neovim release I will update this repo along with the community to keep it up to date with the newest versions.

As I mentioned, this config is meant as a starting point for people new to Neovim who want a familiar IDE experience. The config has a very simple structure that makes it easy to add new plugins.

## Install Neovim 0.8

You can install Neovim with your package manager e.g. brew, apt, pacman etc.. but remember that when you update your packages Neovim may be upgraded to a newer version.

If you would like to make sure Neovim only updates when you want it to than I recommend installing from source:

**NOTE** Verify the required [build prerequisites](https://github.com/neovim/neovim/wiki/Building-Neovim#build-prerequisites) for your system.

```sh
git clone https://github.com/neovim/neovim.git
cd neovim
git checkout release-0.8
make CMAKE_BUILD_TYPE=Release
sudo make install
```

## Install the config

Make sure to remove or move your current `nvim` directory

```sh
git clone https://github.com/LunarVim/nvim-basic-ide.git ~/.config/nvim
```

Run `nvim` and wait for the plugins to be installed

**NOTE** First time you will get an error just ignore them and press enter, it will say nvim-ts-context-commentstring is not installed but that is fine just close and reopen nvim and everything should be fine

**NOTE** (You will notice treesitter pulling in a bunch of parsers the next time you open Neovim)

**NOTE** Checkout this file for some predefined keymaps: [keymaps](https://github.com/LunarVim/nvim-basic-ide/blob/master/lua/user/keymaps.lua)

## Get healthy

Open `nvim` and enter the following:

```
:checkhealth
```

You'll probably notice you don't have support for copy/paste also that python and node haven't been setup

So let's fix that

First we'll fix copy/paste

- On mac `pbcopy` should be builtin

- On Ubuntu

  ```sh
  sudo apt install xsel # for X11
  sudo apt install wl-clipboard # for wayland
  ```

Next we need to install python support (node is optional)

- Neovim python support

  ```sh
  pip install pynvim
  ```

- Neovim node support

  ```sh
  npm i -g neovim
  ```

We will also need `ripgrep` for Telescope to work:

- Ripgrep

  ```sh
  sudo apt install ripgrep
  ```

---

**NOTE** make sure you have [node](https://nodejs.org/en/) installed, I recommend a node manager like [fnm](https://github.com/Schniz/fnm).

## Fonts

I recommend using the following repo to get a "Nerd Font" (Font that supports icons)

[getnf](https://github.com/ronniedroid/getnf)

## Configuration

### LSP

To add a new LSP

First Enter:

```
:Mason
```

and press `i` on the Language Server you wish to install

Next you will need to add the server to this list: [servers](https://github.com/LunarVim/nvim-basic-ide/blob/0e65f504f634026f5765ce6a092612d385d6306d/lua/user/lsp/mason.lua#L1)

Note: Builtin LSP doesn't contain all lsps from [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#terraform_lsp).

If you want to install any from there, for example terraform_lsp(which adds more functionality than terraformls, like complete resource listing),

1. You can add the lsp name in [mason lsp block](https://github.com/LunarVim/nvim-basic-ide/blob/f03955dc1e5879164f9229d44d98ca81a948cbfb/lua/user/lsp/mason.lua#L1-L10)

```lua
-- lua/usr/lsp/mason.lua
local servers = {
	"sumneko_lua",
	"cssls",
	"html",
	"tsserver",
	"pyright",
	"bashls",
	"jsonls",
	"yamlls",
  "terraform_lsp" -- New LSP
}
```

2. Manually install the binary of the lsp and put it in your path by downloading the binary or through your package manager. For terraform_lsp [example](https://github.com/juliosueiras/terraform-lsp/releases)

### Formatters and linters

Make sure the formatter or linter is installed and add it to this setup function: [null-ls](https://github.com/LunarVim/nvim-basic-ide/blob/0e65f504f634026f5765ce6a092612d385d6306d/lua/user/lsp/null-ls.lua#L12)

**NOTE** Some are already setup as examples, remove them if you want

### Plugins

You can install new plugins here: [plugins](https://github.com/LunarVim/nvim-basic-ide/blob/0e65f504f634026f5765ce6a092612d385d6306d/lua/user/plugins.lua#L45)

---

## Plugins

- [packer](https://github.com/wbthomason/packer.nvim)
- [plenary](https://github.com/nvim-lua/plenary.nvim)
- [nvim-web-devicons](https://github.com/kyazdani42/nvim-web-devicons)

### Colorschemes
- [catppuccin](https://github.com/catppuccin/nvim)
- [tokyonight](https://github.com/folke/tokyonight.nvim)
- [kanagawa](https://github.com/rebelot/kanagawa.nvim)

### Completion (cmp)
- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
- [cmp-buffer](https://github.com/hrsh7th/cmp-buffer)
- [cmp-path](https://github.com/hrsh7th/cmp-path)
- [cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip)
- [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp)
- [cmp-nvim-lua](https://github.com/hrsh7th/cmp-nvim-lua)

### Snippets
- [LuaSnip](https://github.com/L3MON4D3/LuaSnip)

### LSP
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
- [mason.nvim](https://github.com/williamboman/mason.nvim)
- [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim)
- [nvim-lint](https://github.com/mfussenegger/nvim-lint)

### Telescope
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
- [telescope-fzf-native](https://github.com/nvim-telescope/telescope-fzf-native.nvim)
- [telescope-file-browser](https://github.com/nvim-telescope/telescope-file-browser.nvim)

### Treesitter
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- [nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects)
- [nvim-ts-context-commentstring](https://github.com/JoosepAlviste/nvim-ts-context-commentstring)

### Quality of Life (QOL)
- [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)
- [nvim-autopairs](https://github.com/windwp/nvim-autopairs)
- [Comment.nvim](https://github.com/numToStr/Comment.nvim)
- [nvim-tree.lua](https://github.com/kyazdani42/nvim-tree.lua)
- [bufferline.nvim](https://github.com/akinsho/bufferline.nvim)
- [vim-bbye](https://github.com/moll/vim-bbye)
- [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)
- [vim-illuminate](https://github.com/RRethy/vim-illuminate)

### Debug Adapter Protocol (DAP)
- [nvim-dap](https://github.com/mfussenegger/nvim-dap)
- [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui)
- [nvim-dap-go](https://github.com/dreamsofcode-io/nvim-dap-go)
- [nvim-dap-python](https://github.com/mfussenegger/nvim-dap-python)

### Go Utilities
- [gopher.nvim](https://github.com/olexsmir/gopher.nvim)

### Context Navigation
- [nvim-navic](https://github.com/SmiteshP/nvim-navic)
- [barbecue.nvim](https://github.com/utilyre/barbecue.nvim)


## Keymaps:

### Normal mode:

- `<leader>d` : Move half page down and center
- `<leader>u` : Move half page up and center

- `<C-h>` : Move to left window
- `<C-j>` : Move to bottom window
- `<C-k>` : Move to top window
- `<C-l>` : Move to right window

- `<C-Up>` : Decrease window height by 2
- `<C-Down>` : Increase window height by 2
- `<C-Left>` : Decrease window width by 2
- `<C-Right>` : Increase window width by 2

- `<S-l>` : Go to next buffer
- `<S-h>` : Go to previous buffer

- `<leader>h` : Clear search highlight

- `<S-q>` : Delete current buffer

- `<leader>e` : Toggle NvimTree
- `<leader>o` : Focus NvimTree

- `<leader>ff` : Find file using Telescope
- `<leader>fg` : Live grep using Telescope
- `<leader>fp` : Projects using Telescope
- `<leader>fb` : Buffers using Telescope

- `<leader>gg` : LazyGit

- `<leader>/` : Toggle comment for current line

- `<leader>db` : Toggle breakpoint
- `<leader>dc` : Continue
- `<leader>di` : Step into
- `<leader>dO` : Step out
- `<leader>do` : Step over
- `<leader>dr` : Restart
- `<leader>dl` : Run last
- `<leader>du` : Toggle UI
- `<leader>dt` : Terminate

- `<leader>lf`: Format current buffer

- `gD` : Go to declaration
- `gd` : Go to definition
- `K` : Show hover
- `gI` : Go to implementation
- `gr` : Go to references

### Visual mode:

- `p` : Remove selected text and paste

- `<` : Remove Indent from selected text
- `>` : Indent selected text

- `<leader>/` : Toggle comment for selected lines

### Insert mode:

- `jk` : Exit insert mode

> The computing scientist's main challenge is not to get confused by the complexities of his own making.

# \- Edsger W. Dijkstra

> > > > > > > Stashed changes
