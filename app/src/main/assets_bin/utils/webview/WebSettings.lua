-- created by lxs7499

import "utils.Theme"
import "utils.webview.WebClient"
import "utils.webview.ChromeClient"

import "android.webkit.*"
import "android.webkit.WebSettings"
import "android.webkit.CookieManager"
import "androidx.webkit.WebSettingsCompat"
import "androidx.webkit.WebViewFeature"

import "android.content.res.Configuration"

local base = {}

function base.handleSettings(ids)
  local settings = ids.webView.getSettings()
  local cookieManager = CookieManager.getInstance()
  settings.setJavaScriptEnabled(true)
  settings.setSaveFormData(true)
  settings.setSupportZoom(true)
  settings.setBuiltInZoomControls(true)
  settings.setDisplayZoomControls(false)
  settings.setAppCacheEnabled(true)
  settings.setCacheMode(WebSettings.LOAD_DEFAULT)
  settings.setLoadWithOverviewMode(true)
  settings.setAllowContentAccess(true)
  settings.setBlockNetworkImage(false)
  settings.setDomStorageEnabled(true)
  settings.setSupportMultipleWindows(true)
  settings.setLoadsImagesAutomatically(true)
  settings.setJavaScriptCanOpenWindowsAutomatically(true)
  settings.setUserAgentString(settings.getUserAgentString())

  cookieManager.setAcceptThirdPartyCookies(ids.webView, true)
  cookieManager.setAcceptCookie(true)

  ids.webView.requestFocusFromTouch()
  ids.webView.setWebViewClient(WebClient())
  ids.webView.setWebChromeClient(ChromeClient(ids))

  base.settings = settings
end

function base.darkModeSupport(state)
  local settings = base.settings
  if WebViewFeature.isFeatureSupported(WebViewFeature.FORCE_DARK) then
    if state == true then
      WebSettingsCompat.setForceDark(settings, WebSettingsCompat.FORCE_DARK_ON)
      if WebViewFeature.isFeatureSupported(WebViewFeature.FORCE_DARK_STRATEGY) then
        WebSettingsCompat.setForceDarkStrategy(settings, WebSettingsCompat.DARK_STRATEGY_PREFER_WEB_THEME_OVER_USER_AGENT_DARKENING)
      end
      return
    end
    WebSettingsCompat.setForceDark(settings, WebSettingsCompat.FORCE_DARK_OFF)
  end
end

return base