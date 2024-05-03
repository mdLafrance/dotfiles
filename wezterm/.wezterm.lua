local wezterm = require('wezterm')

local config = {}

-- Font
config.font = wezterm.font 'JetBrains Mono'

-- Colorscheme
-- config.color_scheme = 'Catppuccin Mocha'

-- Padding
config.window_padding = {
    left = 10,
    right = 10,
    top = 10,
    bottom = 10
}

-- Background opacity
config.window_background_opacity = 0.70

-- Tab management
config.hide_tab_bar_if_only_one_tab = true

return config
