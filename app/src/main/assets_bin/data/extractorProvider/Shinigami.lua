-- created by lxs7499
-- this extractor is now working

local Shinigami = {}
setmetatable(Shinigami, Shinigami)

local cjson = require "cjson"
local ExtractorApi = require "data.ExtractorApi"
local ExtractorData = require "data.ExtractorData"

Shinigami.extractor = ExtractorApi:create("Shinigami", "https://shinigami.id")

function Shinigami.get(url)
  return Shinigami.extractor
  :setUrl(url)
  -- fetch data from web
  :fetchData(function(err, code, body)
    if code ~= 200 then print("failed to extract: " .. tostring(code))
      return error(err)
    end

    local jsoup = Jsoup.parse(body)
    local title = tostring(jsoup.title()):encodeEntity()
    
    local query = table.buildQuery {
      t_u = url:encodeEntity(), t_d = title, t_t = title,
      s_o = "default#version=cd63a892ad6cfe24a51d9c0f999a4afa"
    }

    ExtractorData.disqusEmbed("reaperid", query)
  end)
end

function Shinigami.__call(self)
  self = table.clone(self)
  return self
end

return Shinigami

