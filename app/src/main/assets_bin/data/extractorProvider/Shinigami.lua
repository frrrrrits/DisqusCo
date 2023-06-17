-- created by lxs7499

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
    if code ~= 200 then print("failed to extract: " .. tostring(code)) error(err)
      return
    end
  
    local jsoup = Jsoup.parse(body)
    local parent = jsoup.select("script[id='manga_disqus_embed-js-extra']")
    local child = tostring(parent):match("var.-embedVars.-=(.*);")
    local result = cjson.decode(child)
    
    ExtractorData.extract(
      result.disqusIdentifier,
      result.disqusShortname,
      jsoup.title()
    )
  end)
end

function Shinigami.__call(self)
  self = table.clone(self)
  return self
end

return Shinigami

