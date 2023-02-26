-- created by lxs7499

local ExtractorApi = {}
ExtractorApi.__index = ExtractorApi

function ExtractorApi:create(name, baseUrl)
  return setmetatable({
    url = nil,
    name = name,
    baseUrl = baseUrl,
  }, self)
end

function ExtractorApi:setUrl(str)
  self.url = str
  return self
end

function ExtractorApi:getName()
  return self.name
end

function ExtractorApi:getBaseUrl()
  return self.baseUrl
end

function ExtractorApi:fetchData(func)
  LuaHttp.request({ url = self.url }, func)
  return self
end

return ExtractorApi