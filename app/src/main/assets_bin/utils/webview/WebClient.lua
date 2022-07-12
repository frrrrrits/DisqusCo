-- created by lxs7499

import "id.lxs.disquscoment.webview.LuaWebViewClient"

return function()
  return LuaWebViewClient(LuaWebViewClient.LuaWebClient {
    onReceivedError = function(view, errcode, description, fallurl)
      -- Todo
    end,

    onReceivedHttpError = function(view, request, response)
      -- Todo
    end,

    shouldOverrideUrlLoading = function(view, request)
      local url = request.url
      if url ~= nil then
        view.loadUrl(url)
      end
    end,
  })
end