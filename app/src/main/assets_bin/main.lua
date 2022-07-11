-- created by lxs7499

require "import"
import "initapp"
import "ui.layout.MainLayout"
import "ui.settings.Settings"
import "utils.Theme"
import "utils.Snack"
import "utils.ViewExt"
import "utils.webview"

import "utils.dialog.DialogError"
import "utils.dialog.DialogTextInput"
import "android.webkit.WebViewClient"

local ids = {}
defer dayNightDelegate = DayNightDelegate(this)

function onCreate(savedInstance)
  activity.setContentView(loadlayout(MainLayout(), ids))
  activity.setSupportActionBar(ids.toolbar)

  dayNightDelegate.onCreate(savedInstance)
  dayNightDelegate.setDefaultNightMode(-1)

  webview.handleSettings(ids)
  
  local dialog = DialogTextInput(activity)
  :setTitle("Hello!")
  :setHint("Masukan url")
  :setAllowNull(false)
  :setNeutralButton("Keluar", function(dialog, text)
    activity.finish()
  end)
  :setPositiveButton("Mulai", function(dialog, text)
  end, true, true)

  DialogError(this)
  :message("Gagal mengambil data")
  :positiveButton(function()end)
  :negativeButton(function()end)
  
  dialog:show()
end

function onCreateOptionsMenu(menu,inflater)
  activity.getMenuInflater().inflate(R.menu.main, menu)  
end

function onOptionsItemSelected(menuItem)
  switch menuItem.itemId
    case R.id.action_settings
    Settings()
    case R.id.action_refresh
    case R.id.action_openbrowser
  end
end

function onResume()
  fixWindowFlags()
  onApplyTranslucentSystemBars()
end

function onSaveInstanceState(outState)
  dayNightDelegate.onSaveInstanceState(outState)
end

function onDestroy()
  dayNightDelegate.onDestroy()
end

local lastExitTime = 0
function onKeyDown(KeyCode,event)
  if KeyCode == KeyEvent.KEYCODE_BACK then
    if ids.webView.canGoBack() then
      ids.webView.goBack()
      return true
     else
      if lastExitTime < System.currentTimeMillis() - 2000 then
        print("Tekan lagi untuk keluar")
        lastExitTime = System.currentTimeMillis()
        return true
      end
    end
  end
end