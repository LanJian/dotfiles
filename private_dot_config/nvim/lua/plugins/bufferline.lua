local opts = {
  options = {
    separator_style = 'slant',
    always_show_bufferline = false,
    buffer_close_icon = '',
  },
}

return {
  'akinsho/bufferline.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = opts
}
