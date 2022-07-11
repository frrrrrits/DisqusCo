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

function handleWebSettings(ids)
  local settings = ids.webView.getSettings()
  local cookieManager = CookieManager.getInstance()

  settings.setSaveFormData(true)
  settings.setSupportZoom(true)
  settings.setBuiltInZoomControls(true)
  settings.setDisplayZoomControls(false)
  settings.setAppCacheEnabled(true)
  settings.setCacheMode(WebSettings.LOAD_DEFAULT)
  settings.setLoadWithOverviewMode(true)
  settings.setUseWideViewPort(true)
  settings.setJavaScriptEnabled(true)
  settings.setAllowContentAccess(true)
  settings.setBlockNetworkImage(false)
  settings.setDomStorageEnabled(true)
  settings.setSupportMultipleWindows(true)
  settings.setLoadsImagesAutomatically(true)
  settings.setLayoutAlgorithm(WebSettings.LayoutAlgorithm.SINGLE_COLUMN)
  settings.setPluginState(WebSettings.PluginState.ON)
  settings.setJavaScriptCanOpenWindowsAutomatically(true)

  cookieManager.setAcceptThirdPartyCookies(ids.webView, true)
  cookieManager.setAcceptCookie(true)
  setDarkModeSupport(settings)
  
  ids.webView.requestFocusFromTouch()
  ids.webView.setWebViewClient(WebClient())
  ids.webView.setWebChromeClient(ChromeClient(ids))
  
  window.setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_PAN)
end

function setDarkModeSupport(settings)
  if WebViewFeature.isFeatureSupported(WebViewFeature.FORCE_DARK) then
    if getCurrentThemeMode() == true then
      WebSettingsCompat.setForceDark(settings, WebSettingsCompat.FORCE_DARK_ON)
      if WebViewFeature.isFeatureSupported(WebViewFeature.FORCE_DARK_STRATEGY) then
        WebSettingsCompat.setForceDarkStrategy(settings, WebSettingsCompat.DARK_STRATEGY_PREFER_WEB_THEME_OVER_USER_AGENT_DARKENING)
      end
      return
    end
    WebSettingsCompat.setForceDark(settings, WebSettingsCompat.FORCE_DARK_OFF)
  end
end