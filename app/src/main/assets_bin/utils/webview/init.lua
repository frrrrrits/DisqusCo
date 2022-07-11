-- created by lxs7499

local WebSetting = {}
setmetatable(WebSetting, WebSetting)

import "utils.webview.WebSettings"

WebSetting.handleSettings = function(ids)
  return handleWebSettings(ids)
end

function WebSetting.__call(self)
  self = table.clone(self)
  return self
end
return WebSetting
