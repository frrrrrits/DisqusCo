-- created by lxs7499

local Kiryuu = {}
setmetatable(Kiryuu, Kiryuu)

local cjson = require "cjson"
local ExtractorApi = require "data.ExtractorApi"
local ExtractorData = require "data.ExtractorData"

Kiryuu.extractor = ExtractorApi:create("Kiryuu", "https://kiryuu.id")

function Kiryuu.get(url)
  return Kiryuu.extractor
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
       result.disqusShortname,
       jsoup.title()
    )
  end)
end

function Kiryuu.__call(self)
  self = table.clone(self)
  return self
end

return Kiryuu