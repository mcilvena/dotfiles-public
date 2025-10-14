-- Pull in the wezterm API
local wezterm = require("wezterm")

wezterm.on("user-var-changed", function(window, pane, name, value)
  local overrides = window:get_config_overrides() or {}
  if name == "ZEN_MODE" then
    local incremental = value:find("+")
    local number_value = tonumber(value)
    if incremental ~= nil then
      while number_value > 0 do
        window:perform_action(wezterm.action.IncreaseFontSize, pane)
        number_value = number_value - 1
      end
      overrides.enable_tab_bar = false
    elseif number_value < 0 then
      window:perform_action(wezterm.action.ResetFontSize, pane)
      overrides.font_size = nil
      overrides.enable_tab_bar = true
    else
      overrides.font_size = number_value
      overrides.enable_tab_bar = false
    end
  end
  window:set_config_overrides(overrides)
end)

-- This will hold the configuration.
local config = wezterm.config_builder()

-- https://github.com/wez/wezterm/discussions/4728
local is_darwin <const> = wezterm.target_triple:find("darwin") ~= nil
local is_linux <const> = wezterm.target_triple:find("linux") ~= nil
local is_windows <const> = not (is_darwin or is_linux)

-- This is where you actually apply your config choices
config.color_scheme = "Catppuccin Mocha"

if is_windows then
  -- Get WSL distribution name from environment or fallback to "Ubuntu"
  -- This allows wezterm to automatically connect to the correct WSL environment
  local wsl_distro = os.getenv("WSL_DISTRO_NAME") or "Ubuntu"
  -- Set default domain to launch WSL by default on Windows
  config.default_domain = "WSL:" .. wsl_distro
end

config.enable_wayland = false
--config.font = wezterm.font("JetBrainsMono Nerd Font", { weight = 400 })
config.font = wezterm.font("Cascadia Code", { weight = 400 })
config.line_height = 1.05

-- Platform-specific DPI and font size configuration for consistent appearance
-- Base font size in points for consistent visual size across platforms
local base_font_size = 16

if is_darwin then
  config.font_size = base_font_size + 2
elseif is_windows then
  config.font_size = base_font_size
elseif is_linux then
  config.font_size = base_font_size + 2
end

-- Additional font rendering settings for consistency
config.freetype_load_target = "Normal" -- or "Light" for thinner rendering
config.freetype_render_target = "Normal" -- or "Light" for less bold appearance

config.keys = {
  {
    key = "l",
    mods = "CTRL|SHIFT",
    action = wezterm.action.SplitPane({ direction = "Left" }),
  },
  {
    key = "r",
    mods = "CTRL|SHIFT",
    action = wezterm.action.SplitPane({ direction = "Right" }),
  },
  {
    key = "t",
    mods = "CTRL|SHIFT",
    action = wezterm.action.SplitPane({ direction = "Up" }),
  },
  {
    key = "b",
    mods = "CTRL|SHIFT",
    action = wezterm.action.SplitPane({ direction = "Down" }),
  },
  {
    key = "P",
    mods = "CTRL|SHIFT",
    action = wezterm.action.ActivateCommandPalette,
  },
}

local wezzy_bar =
  wezterm.plugin.require("https://github.com/mcilvena/wezzy-bar")
wezzy_bar.apply_to_config(config, {
  position = "bottom",
  theme = {
    tab_bar_background = "#11111b", -- Custom black
  },
  components = {
    clock = {
      format = "%a %d %b %I:%M",
    },
  },
})

-- Try to load local overrides
local ok, local_config = pcall(require, "wezterm.local")
if ok and local_config then
  for k, v in pairs(local_config) do
    config[k] = v
  end
end

config.window_decorations = "RESIZE"
config.window_background_opacity = 0.92
config.macos_window_background_blur = 15

return config
