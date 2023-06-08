local SettingsAction = {}

import "utils.webview.Utils"
import "android.webkit.WebStorage"
import "android.webkit.CookieManager"

local disqusWeb = function(url, ids)
  ids.webView.visibility = 0
  ids.webView.loadUrl(url)
end

SettingsAction.openAccount = function(account, state, ids)
  if account:get() ~= state.accountLogin then
    disqusWeb(account:get(), ids)
   else
    disqusWeb(Utils.disqus.url, ids)
    return
  end
end

SettingsAction.createDialogDeletion = function(context, account, ids)
  local alertDialog = MaterialAlertDialogBuilder(context)
  .setTitle("Hapus cookie dan cache.")
  .setMessage("Ini akan menghapus semua history cookie, termasuk akun yang telah login, ini tidak dapat di kembalikan.")
  .setNegativeButton("Batalkan", nil)
  .setPositiveButton("Hapus", function()
    account:set(-1)-- reset account
    xpcall(function()
      -- clear the Application Cache, Web SQL Database HTML5 Web Storage
      local cookieManager = CookieManager.getInstance()
      WebStorage.getInstance().deleteAllData()
      -- cookie
      cookieManager.removeAllCookies(nil)
      cookieManager.flush()
      -- WebView
      ids.webView.clearCache(true)
      ids.webView.clearFormData()
      ids.webView.clearHistory()
      ids.webView.clearSslPreferences()
      Snack("Dihapus", true)
    end,
    function(error)
      Snack("Tidak dapat menghapus cache dan cookie.", true)
    end)
  end)
  .create()
  .show()
end


return SettingsAction
