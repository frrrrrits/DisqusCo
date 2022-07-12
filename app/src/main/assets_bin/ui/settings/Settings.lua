-- created by lxs7499

local Settings = {}
setmetatable(Settings, Settings)

import "utils.Snack"
import "utils.bottomsheet.BottomSheet"
import "ui.layout.SettingsLayout"

local state = {
  themeEnabled = 2,
  webEnabled = true,
}

local bo2nu = function(value)
  if value == true then return 2 else return 1 end
end

-- override method
local function checkedListner(view, fun)
  view.setOnCheckedChangeListener { onCheckedChanged = fun }
end

local ids = {}
local preference = require "utils.preference"
local webview = require "utils.webview"

local theme = preference.appThemeMode
local web = preference.webDarkMode

-- intialized prefences
local initPrefrences = function()
  if theme:get() == state.themeEnabled then
    ids.switchDarkMode.checked = true
  end
  if web:get() == state.webEnabled then
    ids.switchWebDarkMode.checked = true
  end
end

-- create views shown bottomsheet
function Settings.init(context)
  local bottomSheet = BottomSheet(context)
  :setView(SettingsLayout(), ids)
  :build()

  initPrefrences()
  
  checkedListner(ids.switchWebDarkMode,function(view, isChecked)
    web:set(isChecked)
    webview.darkModeSupport(isChecked)
  end)

  checkedListner(ids.switchDarkMode, function(view, isChecked)
    theme:set(bo2nu(isChecked))
    AppCompatDelegate.setDefaultNightMode(bo2nu(isChecked))
    activity.recreate()
  end)
end

function Settings.__call(self, context)
  return Settings.init(context)
end

return Settings
