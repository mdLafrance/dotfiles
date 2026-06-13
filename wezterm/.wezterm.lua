local wezterm = require('wezterm')

local config = {}

-- Font
config.font = wezterm.font 'JetBrains Mono'

-- Colorscheme
-- config.color_scheme = 'Catppuccin Mocha'

-- Padding
config.window_padding = {
    left = 5,
    right = 5,
    top = 5,
    bottom = 5
}

config.max_fps = 144

config.macos_window_background_blur = 20

-- Background opacity
config.window_background_opacity = 0.88

-- Tab management
config.hide_tab_bar_if_only_one_tab = true

-- Temporary fix to work on wayland
config.enable_wayland = false



return config
