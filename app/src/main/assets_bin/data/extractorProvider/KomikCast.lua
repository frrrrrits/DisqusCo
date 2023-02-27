-- created by lxs7499

local KomikCast = {}
setmetatable(KomikCast, KomikCast)

local cjson = require "cjson"
local ExtractorApi = require "data.ExtractorApi"
local ExtractorData = require "data.ExtractorData"

KomikCast.extractor = ExtractorApi:create("KomikCast", "https://komikcast.site")

function KomikCast.get(url)
  return KomikCast.extractor
  :setUrl(url)
  -- fetch data from web
  :fetchData(function(err, code, body)
    if code ~= 200 then print("failed to extract: " .. tostring(code)) error(err)
      return
    end
  
    local jsoup = Jsoup.parse(body)
    local parent = jsoup.select("div.komik_info-comments-form > script")
    local child = tostring(parent):match("var.-embedVars.-=(.-);"):gsub("%s{","[{").."]"
    local result = cjson.decode(child)[1]
    
    ExtractorData.extract(
       result.disqusIdentifier,
       result.disqusShortname
    )
  end)
end

function KomikCast.__call(self)
  self = table.clone(self)
  return self
end

return KomikCast