-- created by lxs7499

local Settings = {}
setmetatable(Settings, Settings)

import "utils.Snack"
import "utils.bottomsheet.BottomSheet"
import "ui.layout.SettingsLayout"
import "ui.settings.SettingsAction"

local state = {
  themeEnabled = 2,
  webEnabled = true,
  accountLogin = -1,
}

local toNumber = function(value)
  -- for theme purpose
  if value == true then
    return 2 else return 1 end
end

-- override function
local function checkedListner(view, fun)
  view.setOnCheckedChangeListener { onCheckedChanged = fun }
end

local ids = {}
local extractorManager = require "data.ExtractorManager"
local preference = require "utils.preference"
local webview = require "utils.webview"

local theme = preference.appThemeMode
local web = preference.webDarkMode
local account = preference.disqusAccount

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
function Settings.init(context, mainViews)
  local bottomSheet = BottomSheet(context)
  :setView(SettingsLayout(), ids)
  :build()

  initPrefrences()
  
  ids.refreshDialog.onClick = function()
    bottomSheet:dismiss()
    extractorManager
    .createInputTextDialog(mainViews)
    :setNeutralButton("Batal", nil)
    :show()
  end

  ids.openDisqusAccount.onClick = function()
    bottomSheet:dismiss()
    SettingsAction
    .openAccount(account, state, mainViews)
  end

  ids.deleteCookieCache.onClick = function()
    bottomSheet:dismiss()
    SettingsAction
    .createDialogDeletion(context, account, mainViews)
  end

  checkedListner(ids.switchWebDarkMode, function(view, isChecked)
    web:set(isChecked)
    webview.darkModeSupport(isChecked)
  end)

  checkedListner(ids.switchDarkMode, function(view, isChecked)
    theme:set(toNumber(isChecked))
    AppCompatDelegate.setDefaultNightMode(toNumber(isChecked))
    activity.recreate()
  end)
end

function Settings.__call(self, context, ids)
  return Settings.init(context, ids)
end

return Settings
