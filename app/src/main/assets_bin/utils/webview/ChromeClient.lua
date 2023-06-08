-- created by lxs7499

import "utils.Snack"
import "utils.StringExt"
import "utils.webview.Utils"
import "id.lxs.disquscoment.webview.LuaWebChromeClient"

return function(ids)
  return LuaWebChromeClient(LuaWebChromeClient.LuaChromeCreator {
    onReceivedTitle = function(view, title)
      print(title, true)
      ids.toolbar.title = tostring(title)
    end,
    onCreateWindow = function(view, dialog, gesture, msg)
      local href = view.getHandler().obtainMessage()
      view.requestFocusNodeHref(href)
      local url = tostring(href.getData().getString("url"))
      if url ~= nil then
        Utils.createDialog(url, view)
      end
    end,
  
    onProgressChanged = function(view, progress)
      ids.progressBar.progress = progress
      if progress == 100 then
        ids.progressBar.hide()
       else
        ids.progressBar.show()
      end
    end,
  })
end