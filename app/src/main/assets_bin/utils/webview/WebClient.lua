-- created by lxs7499

import "utils.Snack"
import "utils.StringExt"
import "utils.webview.Utils"
import "id.lxs.disquscoment.webview.LuaWebViewClient"

local function message(url, errorCode, description)
  return string.format("Failed to load: %s\nError code: %d\nDescription: %s",
  tostring(url), tostring(errorCode), tostring(description))
end

return function()
  return LuaWebViewClient(LuaWebViewClient.LuaWebClient {
    onReceivedHttpError = function(view, request, error)
      -- Snack(message(view.url, error.statusCode, error.reasonPhrase), true)
    end,
    shouldOverrideUrlLoading = function(view, request)
      local url = tostring(request.url)
      if url ~= nil then
        Utils.createDialog(url, view)
      end
      Utils.saveUrl(url)
      return true
    end,
  })
end