-- created by lxs7499
-- this extractor is now working

local KomikCast = {}
setmetatable(KomikCast, KomikCast)

local cjson = require "cjson"
local ExtractorApi = require "data.ExtractorApi"
local ExtractorData = require "data.ExtractorData"

KomikCast.extractor = ExtractorApi:create("KomikCast", "https://komikcast.vip")

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
    local child = tostring(parent):match("var.-embedVars.-=(.-)};"):gsub("%s{","[{").."}]"

    local result = cjson.decode(child)[1]
    local title = tostring(jsoup.title()):encodeEntity()
    
    local query = table.buildQuery{
      t_i = result.disqusIdentifier:encodeEntity(),
      t_u = url:encodeEntity(),
      t_e = title, t_d = title, t_t = title,
      s_o = "default#version=cd63a892ad6cfe24a51d9c0f999a4afa"
    }
  
    ExtractorData.disqusEmbed(result.disqusShortname, query)
  end)
end

function KomikCast.__call(self)
  self = table.clone(self)
  return self
end

return KomikCast