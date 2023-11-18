return {
  'ThePrimeagen/harpoon',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    require("harpoon").setup();
    local mark = require("harpoon.mark");
    local ui = require("harpoon.ui");
    vim.keymap.set('n', '<leader>hm', mark.add_file, { desc = '[H]arpoon [M]ark' })
    vim.keymap.set('n', '<leader>ht', ui.toggle_quick_menu, { desc = '[H]arpoon [T]oggle' })
    vim.keymap.set("n", "<leader>hq", function() ui.nav_file(1) end, { desc = '1' })
    vim.keymap.set("n", "<leader>hw", function() ui.nav_file(2) end, { desc = '2' })
    vim.keymap.set("n", "<leader>he", function() ui.nav_file(3) end, { desc = '3' })
    vim.keymap.set("n", "<leader>hr", function() ui.nav_file(4) end, { desc = '4' })
    vim.keymap.set("n", "<leader>ha", function() ui.nav_file(5) end, { desc = '5' })
    vim.keymap.set("n", "<leader>hs", function() ui.nav_file(6) end, { desc = '6' })
    vim.keymap.set("n", "<leader>hd", function() ui.nav_file(7) end, { desc = '7' })
    vim.keymap.set("n", "<leader>hf", function() ui.nav_file(8) end, { desc = '8' })
  end,
}
