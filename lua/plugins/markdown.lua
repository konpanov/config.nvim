vim.keymap.set('n', '<leader>gl', "<cmd>Glow<cr>", { desc = '[G][L]ow' })
vim.keymap.set('n', '<leader>mp', '<Plug>MarkdownPreviewToggle', { desc = '[M]arkdown [P]review' })
return {
  { "ixru/nvim-markdown" },
  {
    "ellisonleao/glow.nvim",
    config = true,
    cmd = "Glow"
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd    = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft     = { "markdown" },
    config = function()
      vim.g.mkdp_auto_start = 1
      vim.g.mkdp_auto_close = 0
      vim.g.mkdp_combine_preview = 1
      vim.g.mkdp_combine_preview_auto_refresh = 1
    end,
    build  = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
}
