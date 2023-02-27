string.startswith = function(self, pattern)
  return self:find("^" .. pattern) ~= nil
end

string.endswith = function(self, pattern)
  return string.find(self, pattern, -#pattern) ~= nil
end