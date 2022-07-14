-- created by lxs7499

local Theme={}
setmetatable(Theme,Theme)

import "resource"
import "android.content.res.Resources"
import "rikka.material.app.DayNightDelegate"

local BuildVersion = Build.VERSION
local VersionCodes = Build.VERSION_CODES

function onApplyTranslucentSystemBars(ids)
  window.statusBarColor = Color.TRANSPARENT
  if BuildVersion.SDK_INT >= VersionCodes.P then
    window.decorView.post {
      run = function()
        local insetsBottom = window.decorView.rootWindowInsets.systemWindowInsetBottom
        if insetsBottom ~= 0 then
          window.navigationBarDividerColor =resource.resolveColor(android.R.attr.navigationBarDividerColor) and 0x35ffffff or -0x2000000
          window.navigationBarColor = ColorUtils.setAlphaComponent(MaterialColors.getColor(this, android.R.attr.navigationBarColor, Color.BLACK), 222)
         else
          window.navigationBarColor = Color.TRANSPARENT
        end
      end
    }
  end

  local success, error = pcall(function()
    ApplyWindowInsetsListener(ids.coordinator, function(view, insets)
      local systemBar = insets.getInsets(WindowInsetsCompat.Type.systemBars())
      view.setPadding(systemBar.left,0,systemBar.right,0)
      return insets
    end)
  end)

  if not success then
    print("failed to apply EdgeToEdge.")
  end

  ViewCompat.requestApplyInsets(ids.coordinator)
end

function getStyledAttrBool(r)
  local a = activity.obtainStyledAttributes({r})
  local r = a.getBoolean(0, false)
  a.recycle()
  return r
end

function fixWindowFlags()
  local flags = window.decorView.systemUiVisibility
  if BuildVersion.SDK_INT >= VersionCodes.M then
    local windowLightStatusBar = getStyledAttrBool(android.R.attr.windowLightStatusBar)
    if windowLightStatusBar then
      flags = flags or View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR
     else
      flags = flags and View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR
    end
  end
  if BuildVersion.SDK_INT >= Build.VERSION_CODES.O_MR1 then
    local windowLightNavigationBar = getStyledAttrBool(android.R.attr.windowLightNavigationBar)
    if windowLightNavigationBar then
      flags = flags or View.SYSTEM_UI_FLAG_LIGHT_NAVIGATION_BAR
     else
      flags = flags and View.SYSTEM_UI_FLAG_LIGHT_NAVIGATION_BAR
    end
  end
  window.decorView.systemUiVisibility = flags
  WindowCompat.setDecorFitsSystemWindows(window, false)
end

return Theme
