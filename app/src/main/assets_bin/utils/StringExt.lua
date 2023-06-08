string.startswith = function(self, pattern)
  return self:find("^" .. pattern) ~= nil
end

string.endswith = function(self, pattern)
  return string.find(self, pattern, -#pattern) ~= nil
end

string.decodeEntity = function(self)
  import "java.net.URLDecoder"
  return URLDecoder.decode(self, "UTF-8")
end