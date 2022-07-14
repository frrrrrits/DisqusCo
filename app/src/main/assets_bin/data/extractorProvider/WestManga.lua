-- created by lxs7499

local WestManga = {}
setmetatable(WestManga, WestManga)

local cjson = require "cjson"
local ExtractorApi = require "data.ExtractorApi"
local ExtractorData = require "data.ExtractorData"

WestManga.extractor = ExtractorApi:create("WestManga", "https://westmanga.info")

function WestManga.get(url)
  return WestManga.extractor
  :setUrl(url)
  -- fetch data from web
  :fetchData(function(err, code, body)
    if code ~= 200 then print("failed to extract: " .. tostring(code)) error(err)
      return
    end
  
    local jsoup = Jsoup.parse(body)
    local parent = jsoup.select("script[id='disqus_embed-js-extra']")
    local child = tostring(parent):match("var.-embedVars.-=(.-);"):gsub("%s{","[{").."]"
    local result = cjson.decode(child)[1]
    
    ExtractorData.extract(
      result.disqusIdentifier,
      result.disqusShortname
    )
  end)
end

function WestManga.__call(self)
  self = table.clone(self)
  return self
end

return WestManga