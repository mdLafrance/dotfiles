local wezterm = require('wezterm')

local config = {}

-- Font
config.font = wezterm.font 'JetBrains Mono'

-- Colorscheme
config.color_scheme = 'Catppuccin Mocha'

-- Padding
config.window_padding = {
    left = 15,
    right = 15,
    top = 15,
    bottom = 15
}

-- Background opacity
config.window_background_opacity = 0.8

-- Tab management
config.hide_tab_bar_if_only_one_tab = true

return config
