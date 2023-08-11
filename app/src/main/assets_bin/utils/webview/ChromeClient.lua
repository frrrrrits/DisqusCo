-- created by lxs7499

import "utils.Snack"
import "utils.StringExt"
import "utils.webview.Utils"
import "id.lxs.disquscoment.webview.LuaWebChromeClient"

return function(ids)

  -- hardcode lol
  local removeSubtitle = function()
    ids.toolbar.setLayoutTransition(nil)
    activity.getSupportActionBar().subtitle = ""
  end

  local findsVar = function(str)
    local _start, _end, result =
    string.find(str, "var diqus_title = (.-);")
    if _start ~= nil then
      return result:decodeEntity()
      :gsub("'","")
    end
    return nil
  end

  string.setAsTitleBar = function(self)
    local web_title = findsVar(self)
    if web_title ~= nil then
      return web_title:asTitleBar()
    end
    return self:asTitleBar()
  end

  string.setAsSubtitleBar = function(self)
    local web_title = findsVar(self)
    if web_title == nil return removeSubtitle() end
    local lower_case = web_title:lower()
    local start_idx, end_idx = string.find(lower_case, "chapter")
    if start_idx ~= nil then
      local result = string.sub(web_title, start_idx)
      result:asSubtitleBar()
     else
      removeSubtitle()
    end
  end

  return LuaWebChromeClient(LuaWebChromeClient.LuaChromeCreator {
    onReceivedTitle = function(view, title)
      title:setAsTitleBar()
      title:setAsSubtitleBar()
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