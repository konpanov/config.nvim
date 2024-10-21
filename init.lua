local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- See `:help mapleader`
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Navigation
vim.keymap.set("n", "<leader>r", "<cmd>so$MYVIMRC<cr>")
vim.keymap.set("t", "<ESC><ESC>", "<C-\\><C-N>")

-- Netrw settings
vim.g.netrw_banner = false
vim.api.nvim_create_user_command("E", "Explore", {})
-- Options
vim.o.nu = true -- line number
vim.o.rnu = true -- relative line number
vim.o.top = true -- tilede as operator
vim.keymap.set("n", "<F10>", function()
	vim.cmd('cexpr system("h:src/build.bat")')
	-- vim.cmd 'cexpr system("python C:/Users/costech/work/p1/p1-integracja/src/test.py")'
end, {})
-- vim.opt.infercase = true -- Try out after sometime using vim completion
-- TODO:(kpa) Create a keybind/command to remind completion commands or reconsider which-key
vim.opt.wildignore = vim.opt.wildignore + "*/venv/*" + "*/certificates/other/*"
vim.opt.wildmenu = true
vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,terminal"
vim.opt.showmode = false
vim.opt.clipboard = "unnamedplus"
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = false
vim.opt.list = true
vim.opt.listchars = { tab = "| ", trail = "·", nbsp = "␣" }
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.hlsearch = true

-- Obsidian
vim.keymap.set("n", "<leader>od", vim.fn.strftime("<cmd>new C:/Users/costech/obsd/5 jrnl/%Y_%m_%d.md<cr>"))

-- Formatter keymaps
-- vim.api.nvim_create_autocmd('FileType', {
--  pattern = 'python',
--  callback = function()
--    vim.keymap.set('n', '<leader>f', '<cmd> !black -q %<cr>', { desc = 'Run black formatter' })
--  end,
--})

vim.opt.makeprg = ""

-- Git
vim.keymap.set("n", "<leader>mg", ":silent make! git")
gitcommand = function(opts)
	if opts and opts.args and opts.args == "" then
		opts.args = "status"
	end
	vim.cmd("silent make! git " .. opts.args)
end
vim.api.nvim_create_user_command("G", gitcommand, { nargs = "*" })
vim.keymap.set("n", "<leader>gs", "<cmd>silent make! git status<cr>")

-- Diagnostic keymaps
--
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

hl_on_yank = function()
	vim.highlight.on_yank()
end
vim.api.nvim_create_autocmd("TextYankPost", { callback = hl_on_yank })

vim.g["csv_format"] = "csvformat"

if vim.fn.filereadable("session.lua") == 1 then
	vim.cmd("source session.lua")
end

if vim.fn.filereadable("Session.vim") == 1 then
	vim.cmd("source Session.vim")
end

vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function()
		if vim.bo.ft == "lua" then
			vim.keymap.set("n", "<leader>f", "<cmd>silent make! stylua %<cr>")
		elseif vim.bo.ft == "go" then
			vim.keymap.set("n", "<leader>f", "<cmd>silent make! gofmt -w %<cr>")
		elseif vim.bo.ft == "python" then
			vim.keymap.set("n", "<leader>f", "<cmd>silent make! ruff format %<cr>")
			-- vim.keymap.set('n', '<leader>ll', '<cmd>silent make! ruff check % --select I --config ./pyproject.toml<cr>')
			-- vim.keymap.set('n', '<leader>lf', '<cmd>silent make! ruff check % --select I --fix --config ./pyproject.toml<cr>')
			vim.keymap.set("n", "<leader>ll", "<cmd>silent make! ruff check % --select I --config ./pyproject.toml<cr>")
			vim.keymap.set(
				"n",
				"<leader>lf",
				"<cmd>silent make! ruff check % --select I --fix --config ./pyproject.toml<cr>"
			)
		end
	end,
})

vim.keymap.set("n", "<leader><F5>", vim.cmd.UndotreeToggle)
require("lazy").setup({
	{
		"mbbill/undotree",
		init = function()
			vim.g.undotree_DiffCommand = "FC"
			vim.g.undotree_DiffAutoOpen = 0
			vim.g.undotree_ShortIndicators = 1
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
		init = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader><leader>f", builtin.find_files, { desc = "Telescope find files" })
			vim.keymap.set("n", "<leader><leader>g", builtin.live_grep, { desc = "Telescope live grep" })
			vim.keymap.set("n", "<leader><leader>b", builtin.buffers, { desc = "Telescope buffers" })
			vim.keymap.set("n", "<leader><leader>h", builtin.help_tags, { desc = "Telescope help tags" })
		end,
	},
}, {})

-- Telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
