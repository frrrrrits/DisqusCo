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
local lastUrl = preference.lastUrl

function Utils.getLastUrl()
  local url = lastUrl:get()
  if url == -1 then return disqus.url
   else return lastUrl:get()
  end
end

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

local function disqusEmbedData(data)
  return disqusEmbed(
     data.disqusIdentifier,
     data.disqusShortname,
     data.webTitle
  )
end

function Utils.loadUrl(ids, data)
  if data.isExtract then
    local html = nil
    html = disqusEmbedData(data)
    ids.loadData(html, "text/html", nil)
   else
    ids.loadUrl(data.disqusEmbedUrl)
  end
  table.clear(data)
end

local function load_dialog(args)
  local args = args or {}
  if not activity.isFinishing() then
    local dialog = MaterialDialog(this)
    :title(args.title)
    :message(args.message)
    for _, value in ipairs(args.button) do
      if value.positive then
        dialog:positiveButton(value.positive, value[1])
       elseif value.negative then
        dialog:negativeButton(value.negative, value[1])
      end
    end
    dialog:show()
    return dialog
  end
end

function Utils.createDialog(url, ids)
  local decodeUrl = URLDecoder.decode(url, "UTF-8")
  if ExtractorManager.checkExtractor(decodeUrl) then
    local dialog = load_dialog {
      title = "Muat extractor?",
      message = "Memuat disqus komen.",
      button = {
        { positive = "Muat", lambda():
          ExtractorManager.fetchData(url, ids)
        },
        { negative = "Muat website asli.",
          lambda(): ids.loadUrl(decodeUrl)
        }
      },
    }
    return
   else
    local dialog = load_dialog {
      title = "Muat website?",
      message = "Extractor tidak ditemukan, ingin memuat website asli?",
      button = {
        { positive = "Muat", lambda():
          ids.loadUrl(decodeUrl)
        },
        { negative = "Batal", nil}
      },
    }
  end
end

return Utils