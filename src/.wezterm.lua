-- Pull in the wezterm API
local wezterm = require("wezterm")

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
config.font = wezterm.font("JetBrainsMono Nerd Font", { weight = 400 })
config.line_height = 1.1

-- Platform-specific DPI and font size configuration for consistent appearance
if is_darwin then
  -- macOS - Common Apple displays
  config.font_size = 13
  config.dpi = 163 -- MacBook Air/Pro Retina displays
elseif is_windows then
  -- Windows/WSL - Common high-DPI displays
  config.font_size = 12
  config.dpi = 144 -- Common Windows high-DPI (150% scaling)
elseif is_linux then
  -- Linux - Varies widely, adjust based on your specific setup
  config.font_size = 12
  config.dpi = 96 -- Standard Linux DPI, adjust for your monitor
end

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
  zones = {
    left = { "tabs" },
    right = { "clock" },
  },
  theme = {
    tab_bar_background = "#0C0C0C", -- Custom black
  },
})

-- Try to load local overrides
local ok, local_config = pcall(require, "wezterm.local")
if ok and local_config then
  for k, v in pairs(local_config) do
    config[k] = v
  end
end

return config
