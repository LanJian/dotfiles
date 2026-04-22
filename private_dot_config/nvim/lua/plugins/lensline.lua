local opts = {
  profiles = {
    {
      name = 'default',
      style = {
        placement = "inline",
        prefix = '',
      },
    }
  }
}

return {
  "oribarilan/lensline.nvim",
  tag = "2.0.0",
  event = "LspAttach",
  opts = opts,
}
