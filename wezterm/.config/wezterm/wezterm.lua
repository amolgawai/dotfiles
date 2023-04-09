-- Pull in the wezterm API
local wezterm = require 'wezterm'
local mux = wezterm.mux

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'OneHalfDark'

-- Fonts
config.font = wezterm.font 'SauceCodePro Nerd Font Mono'
config.font_size = 20

-- startup config
wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
  -- Create a split occupying the right 1/3 of the screen
  -- pane:split { size = 0.3 }
  -- Create another split in the right of the remaining 2/3
  -- of the space; the resultant split is in the middle
  -- 1/3 of the display and has the focus.
  -- pane:split { size = 0.5 }
end)

-- and finally, return the configuration to wezterm
return config
