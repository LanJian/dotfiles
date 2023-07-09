require('lualine').setup {
  options = {
    theme = 'nightfox',
    component_separators = { left = '',  right = ''},
    section_separators = { left = '', right = ''},
  },
  sections = {
    lualine_c = {'filename', 'g:coc_status'},
    lualine_x = {'filetype', 'aerial'},
    lualine_y = {
      {
        'diagnostics',
        -- table of diagnostic sources, available sources:
        -- nvim_lsp, coc, ale, vim_lsp
        sources = {'coc'},
        -- displays diagnostics from defined severity
        sections = {'error', 'warn', 'info', 'hint'},
        -- all colors are in format #rrggbb
        symbols = {error = ' ', warn = ' ', hint = ' '},
      },
    },
  },
}
