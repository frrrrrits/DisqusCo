-- created by lxs7499

local Preference = require "utils.preference.Preference"

-- create shared data
local base = {
  webDarkMode = Preference.create("web_dark_mode", true),
  appThemeMode = Preference.create("app_theme_mode", true),
  disqusAccount = Preference.create("disqus_account", -1),
}

return setmetatable(base, base)