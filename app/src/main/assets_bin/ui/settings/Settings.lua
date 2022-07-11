-- created by lxs7499

local Settings={}
setmetatable(Settings,Settings)

import "utils.bottomsheet.BottomSheet"
import "ui.layout.SettingsLayout"

local ids = {}

function Settings.init()
  local bottomSheet = BottomSheet(this)
  :setView(SettingsLayout(), ids)
  :build() 
end

function Settings.__call(self)
  return Settings.init()
end

return Settings
