local options = {
  styles = {
    comments = "italic",
  },
  modules = {
    gitsigns = true,
  }
}

local palettes = {
  nightfox = {
    bg0 = '#18222e',
    bg1 = '#131A24',
    bg2 = '#192330',
    bg3 = '#1e2938',
    bg4 = '#665673',
    fg3 = '#3b4261',
    comment = '#464e59',
  }
}
local specs = {
  all = {
    git = {
      add = '#266d6a',
      changed = '#b366b2'
    }
  }
}

require('nightfox').setup({
  options = options,
  palettes = palettes,
  specs = specs,
  groups = groups,
})
