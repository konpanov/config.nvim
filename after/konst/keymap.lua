local telescope = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', telescope.find_files, {desc='Files'})
vim.keymap.set('n', '<C-p>', telescope.git_files, {desc='Git'})
vim.keymap.set('n', '<leader>ps', telescope.live_grep, {desc='Search'})

local mark = require('harpoon.mark')
local ui = require('harpoon.ui')
vim.keymap.set('n', "<leader>a", mark.add_file, {desc="Add to harpoon"})
vim.keymap.set('n', "<C-e>", ui.toggle_quick_menu, {desc="Add to harpoon"})
vim.keymap.set('n', "<A-1>", function() ui.nav_file(1) end, {desc="Harpoon file 1"})
vim.keymap.set('n', "<A-2>", function() ui.nav_file(2) end, {desc="Harpoon file 2"})
vim.keymap.set('n', "<A-3>", function() ui.nav_file(3) end, {desc="Harpoon file 3"})
vim.keymap.set('n', "<A-4>", function() ui.nav_file(4) end, {desc="Harpoon file 4"})



vim.keymap.set('n', "<leader>g", function()end, {desc="Git"})
vim.keymap.set('n', "<leader>gs", vim.cmd.Git, {desc="Status"})

vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, {desc='Undotree'})



vim.keymap.set('n', '<leader>p', function()end, {desc='Project'})

local wk = require("which-key")
wk.setup()
wk.register({
	e = {"<cmd>Ex<cr>", "Explore"}
}, {prefix = "<leader>" })

