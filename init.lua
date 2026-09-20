--==================================================
-- OPTIONS
--==================================================

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.smartindent = true
vim.opt.autoindent = true
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
  { src = "https://github.com/ellisonleao/gruvbox.nvim" },

  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/mason-org/mason.nvim.git" },
  { src = "https://github.com/saghen/blink.lib" },
  { src = "https://github.com/saghen/blink.cmp" },
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/nvim-mini/mini.nvim" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter.git" },
  { src = "https://github.com/folke/snacks.nvim.git" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },

  { src = "https://github.com/chomosuke/typst-preview.nvim.git" },
  {
    src = "https://github.com/obsidian-nvim/obsidian.nvim",
    version = vim.version.range "*",
  },
  { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
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
cmp.build():pwait()
cmp.setup()

-- OIL
require('oil').setup({
  columns = {
    "permissions",
    "size",
    "mtime",
    "icon",
  },
})
vim.keymap.set('n', '-', ":Oil<CR>")

-- MINI.NVIM
require('mini.pairs').setup()
require('mini.surround').setup()
require('mini.cursorword').setup()
require('mini.hipatterns').setup({
  highlighters = {
    hex_color = require('mini.hipatterns').gen_highlighter.hex_color(),
  },
})
require('mini.tabline').setup()
vim.keymap.set('n', 'L', ':bnext<CR>', { silent = true })
vim.keymap.set('n', 'H', ':bprevious<CR>', { silent = true })

-- TREESITTER
require('nvim-treesitter').setup()
require('nvim-treesitter').install { 'bash', 'python', 'c', 'lua', 'nix' }
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'bash', 'python', 'c', 'lua', 'nix' },
  callback = function() vim.treesitter.start() end,
})

-- SNACKS
require('snacks').setup({
  picker = { enabled = true },
  image = {

    -- for Obsidian
    resolve = function(path, src)
      local api = require "obsidian.api"
      if api.path_is_note(path) then
        return api.resolve_attachment_path(src)
      end
    end,
  },
})
vim.keymap.set('n', '<leader><space>', ":lua Snacks.picker.files()<CR>")
vim.keymap.set('n', '<leader>/', ":lua Snacks.picker.grep()<CR>")

-- OBSIDIAN
require("obsidian").setup {
  legacy_commands = false, -- this will be removed in 4.0.0
  workspaces = {
    {
      name = "privrepo",
      path = "~/privrepo",
    },
  },
  picker = {
    name = "snacks.picker",
  },
}
vim.opt_local.conceallevel = 2
vim.keymap.set("n", "<leader>oo", ":Obsidian<CR>")
vim.keymap.set("n", "<leader>ot", ":Obsidian tags<CR>")
vim.keymap.set("n", "<C-o>", ":Obsidian quick_switch<CR>")

-- ICONS
require('nvim-web-devicons').setup()

-- MARKDOWN
require('render-markdown').setup()

-- TYPST
require('typst-preview').setup({
  debug = true,
  dependencies_bin = {
    tinymist = "tinymist",
    websocat = "websocat"
  },
})

--==================================================
-- USEFULL STUFF
--==================================================

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "lua", "qml", "nix" },
  callback = function()
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 2
    vim.bo.softtabstop = 2
    vim.bo.expandtab = true
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "typst", "text" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true -- Evita cortar palabras a la mitad
    -- Opcional: muestra símbolos de continuación visual si lo deseas
    -- vim.opt_local.breakindent = true
    vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
    vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
    vim.keymap.set("x", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
    vim.keymap.set("x", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
  end,
})

--==================================================
-- APPAREANCE
--==================================================

vim.opt.termguicolors = true
require("tokyonight").setup()
require("gruvbox").setup({
  terminal_colors = true,
  bold = false,
  italic = {
    strings = false,
    emphasis = false,
    comments = false,
    operators = false,
    folds = false,
  },

  overrides = {
    SignColumn = { bg = "#3c3836" },
    LineNr = { bg = "#3c3836" },
    --CursorLine = { bg = "#282828"},
    CursorLineNr = { fg = "#fe8019", bold = true },
    DiagnosticSignWarn = { fg = "#fabd2f", bg = "#3c3836" },
    DiagnosticSignError = { fg = "#fb4934", bg = "#3c3836" },
    ["@lsp.type.function.lua"] = { fg = "#fe8019" },
  },
})

vim.cmd.colorscheme("gruvbox")

--vim.cmd(":hi statusline guibg=NONE")

-- local function set_transparent() -- set UI component to transparent
-- 	local groups = {
-- 		"Normal",
-- 		"NormalNC",
-- 		"EndOfBuffer",
-- 		"NormalFloat",
-- 		"FloatBorder",
-- 		--"SignColumn",
-- 		--"StatusLine",
-- 		"StatusLineNC",
-- 		"TabLine",
-- 		"TabLineFill",
-- 		"TabLineSel",
-- 		"ColorColumn",
-- 	}
-- 	for _, g in ipairs(groups) do
-- 		vim.api.nvim_set_hl(0, g, { bg = "none" })
-- 	end
-- 	--vim.api.nvim_set_hl(0, "TabLineFill", { bg = "none", fg = "#767676" })
-- end
--
-- set_transparent()
