-- created by lxs7499

import "id.lxs.disquscoment.webview.LuaWebChromeClient"

return function(ids)
  return LuaWebChromeClient(LuaWebChromeClient.LuaChromeCreator {
    onReceivedTitle = function(view, title)
      title:asTitleBar()
      -- view.url:asSubtitleBar()
    end,
  
    onCreateWindow = function(view, dialog, gesture, msg)
      -- Todo
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