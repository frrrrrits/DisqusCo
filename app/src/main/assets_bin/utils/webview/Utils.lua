-- created by lxs7499

import "utils.ViewExt"
import "utils.StringExt"
import "data.ExtractorManager"
import "utils.dialog.MaterialDialog"
import "java.net.URLDecoder"

local Utils = {}
local preference = require "utils.preference"

local disqus = {
  url = "https://disqus.com",
  homePath = "/home",
  profilePath = "/by",
}

Utils.disqus = disqus

local account = preference.disqusAccount

function Utils.saveUrl(url)
  local url = tostring(url)
  if url:startswith(disqus.url .. disqus.homePath)
    or url:startswith(disqus.url .. disqus.profilePath) then
    if account:get() == -1 then
      account:set(url)
    end
  end
end

local function disqusEmbed(disqusIdentifier, disqusShortname, webTitle)
  return "<div id='disqus_thread'></div>"
  .. "<script type='text/javascript'>"
  .. "var disqus_identifier = '" .. disqusIdentifier .. "';"
  .. "var disqus_shortname = '" .. disqusShortname .. "';"
  .. "var diqus_title = '" .. webTitle .. "';"
  .. " (function() { var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;"
  .. "dsq.src = 'https://' + disqus_shortname + '.disqus.com/embed.js';"
  .. "(document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq); })();"
  .. "</script>"
end

function Utils.loadUrl(ids, data)
  local html = nil
  html = disqusEmbed(data.disqusIdentifier, data.disqusShortname, data.webTitle)
  ids.loadData(html, "text/html", nil)
  table.clear(data)
end

function Utils.createDialog(url, ids)
  local decodeUrl = URLDecoder.decode(url, "UTF-8")
  if ExtractorManager.checkExtractor(decodeUrl) then
    local dialog = MaterialDialog(this)
    :title("Muat extractor?")
    :message("Memuat disqus komen.")
    :positiveButton("Muat", function()
      ExtractorManager.fetchData(url, ids)
    end)
    :negativeButton("Muat website", function()
      ids.loadUrl(decodeUrl)
    end)
    dialog:show()
    return
   else
    ids.loadUrl(decodeUrl)
  end
end

return Utils