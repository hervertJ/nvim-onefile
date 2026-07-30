--==================================================
-- OPTIONS
--==================================================

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.termguicolors = true
vim.opt.swapfile = false
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.clipboard = "unnamedplus"

vim.opt.winborder = "rounded"

--==================================================
-- GENERAL KEYMAPS
--==================================================

vim.g.mapleader = " "
vim.keymap.set('n', '<leader>q', ':quit<CR>')

--==================================================
-- PLUGINS
--==================================================

vim.pack.add({
	{ src = "https://github.com/folke/tokyonight.nvim.git" },
	{ src = "https://github.com/RRethy/base16-nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim.git" },
	{ src = "https://github.com/saghen/blink.lib" },
	{ src = "https://github.com/saghen/blink.cmp" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/chomosuke/typst-preview.nvim.git" },
	{ src = "https://github.com/nvim-mini/mini.nvim" },
})

--==================================================
-- COFING PLUGINS
--==================================================

-- LSP

vim.lsp.enable({ "lua_ls", "tinymist", "clangd", "pyright", "nil_ls" })
vim.keymap.set('n', '<leader>uf', vim.lsp.buf.format)
vim.keymap.set('n', '<leader>ud', function() --on/off warnigns
	if vim.diagnostic.is_enabled() then
		vim.diagnostic.enable(false)
	else
		vim.diagnostic.enable(true)
	end
end, { desc = "Toggle Diagnostics" })

-- MASON

require('mason').setup()

-- BLINK-CMP

local cmp = require('blink.cmp')
cmp.setup({
	keymap = {
		['<CR>'] = { 'accept', 'fallback', },
	},
})

--cmp.build = function() require('blink.cmp').build():pwait() end

cmp.build():pwait()
cmp.setup()

-- OIL

require('oil').setup()

vim.keymap.set('n', '-', ":Oil<CR>")

-- MINI.NVIM

require('mini.pairs').setup()
require('mini.pick').setup()
require('mini.surround').setup()

vim.keymap.set('n', '<leader>f', ":Pick files<CR>")

--==================================================
-- APPAREANCE
--==================================================

vim.cmd("colorscheme tokyonight-night")
vim.cmd(":hi statusline guibg=NONE")
