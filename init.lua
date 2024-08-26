-- See `:help mapleader`
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Navigation
vim.keymap.set('n', '<leader>r', '<cmd>so$MYVIMRC<cr>')
vim.keymap.set('t', '<ESC><ESC>', '<C-\\><C-N>')

-- Netrw settings
vim.g.netrw_banner = false
vim.api.nvim_create_user_command('E', 'Explore', {})
-- Options
vim.o.nu = true -- line number
vim.o.rnu = true -- relative line number
vim.o.top = true -- tilede as operator
vim.keymap.set('n', '<F10>', function()
  vim.cmd 'cexpr system("h:src/build.bat")'
  -- vim.cmd 'cexpr system("python C:/Users/costech/work/p1/p1-integracja/src/test.py")'
end, {})
-- vim.opt.infercase = true -- Try out after sometime using vim completion
-- TODO:(kpa) Create a keybind/command to remind completion commands or reconsider which-key
vim.opt.wildignore = vim.opt.wildignore + '*/venv/*' + '*/certificates/other/*'
vim.opt.wildmenu = true
vim.opt.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,terminal'
vim.opt.showmode = false
vim.opt.clipboard = 'unnamedplus'
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = false
vim.opt.list = true
vim.opt.listchars = { tab = '| ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.hlsearch = true

-- Obsidian
vim.keymap.set('n', '<leader>od', vim.fn.strftime '<cmd>new C:/Users/costech/obsd/5 jrnl/%Y_%m_%d.md<cr>')

-- Formatter keymaps
-- vim.api.nvim_create_autocmd('FileType', {
--  pattern = 'python',
--  callback = function()
--    vim.keymap.set('n', '<leader>f', '<cmd> !black -q %<cr>', { desc = 'Run black formatter' })
--  end,
--})

vim.opt.makeprg = ''
vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function()
    if vim.bo.ft == 'lua' then
      vim.keymap.set('n', '<leader>f', '<cmd>silent make! stylua %<cr>')
    elseif vim.bo.ft == 'python' then
      vim.keymap.set('n', '<leader>f', '<cmd>silent make! ruff format %<cr>')
      -- vim.keymap.set('n', '<leader>ll', '<cmd>silent make! ruff check % --select I --config ./pyproject.toml<cr>')
      -- vim.keymap.set('n', '<leader>lf', '<cmd>silent make! ruff check % --select I --fix --config ./pyproject.toml<cr>')
      vim.keymap.set('n', '<leader>ll', '<cmd>silent make! ruff check % --select I --config ./pyproject.toml<cr>')
      vim.keymap.set('n', '<leader>lf', '<cmd>silent make! ruff check % --select I --fix --config ./pyproject.toml<cr>')
    end
  end,
})

-- Git
vim.keymap.set('n', '<leader>mg', ':silent make! git')
vim.api.nvim_create_user_command('G', function(opts) vim.cmd('silent make! git ' .. opts.args) end, {nargs="*"})
vim.keymap.set('n', '<leader>gs', '<cmd>silent make! git status<cr>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

hl_on_yank = function() vim.highlight.on_yank() end
vim.api.nvim_create_autocmd('TextYankPost', { callback = hl_on_yank })
