require "import"
import "initapp"
import "utils.Theme"
import "utils.Snack"
import "utils.ViewExt"
import "utils.ContextExt"
import "utils.StringExt"
import "ui.layout.MainLayout"
import "ui.settings.Settings"

local ids = {}
local webview = require "utils.webview"
local preference = require "utils.preference"
local dayNightDelegate = DayNightDelegate(this)

function onCreate(savedInstance)
  activity.setContentView(loadlayout(MainLayout(), ids))
  activity.setSupportActionBar(ids.toolbar)

  dayNightDelegate.onCreate(savedInstance)

  webview.handleSettings(ids)
  webview.darkModeSupport(preference.webDarkMode:get())

  if savedInstance ~= nil then
    ids.webView.loadUrl(Utils.disqus.url)
  end

  fixWindowFlags()
  onApplyTranslucentSystemBars(ids)
  ids.appbar.backgroundColor = resource.resolveColor(R.attr.colorSurface)
end

function onCreateOptionsMenu(menu, inflater)
  activity.getMenuInflater().inflate(R.menu.main, menu)
end

function onOptionsItemSelected(menuItem)
  switch menuItem.itemId
   case R.id.action_settings
    Settings(this, ids)
   case R.id.action_refresh
    ids.webView.reload()
   case R.id.action_openbrowser
    openInBrowser(ids.webView.url)
  end
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