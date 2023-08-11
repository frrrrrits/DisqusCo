string.startswith = function(self, pattern)
  return self:find("^" .. pattern) ~= nil
end

string.endswith = function(self, pattern)
  return string.find(self, pattern, -#pattern) ~= nil
end

string.decodeEntity = function(self)
  import "java.net.URLDecoder"
  return URLDecoder.decode(self, "UTF_8")
end

string.encodeEntity = function(self)
  import "java.net.URLEncoder"
  return URLEncoder.encode(self, "UTF_8")
end

table.buildQuery = function(tab)
  local query, keys = {}, {}
  local separator = "&amp;"
  -- store 'tab' key to 'keys' table 
  for k,v in pairs(tab) do
    table.insert(keys, {key=k,value=v})
  end
  table.sort(keys, function(a, b)
    return a.key > b.key
  end)
  for _,name in ipairs(keys) do
    -- match value keys.key == tab.key and got the value
    local value = tab[name.key]
    -- add to 'query' table
    query[#query+1] = string.format('%s=%s', name.key, value)
  end
  return table.concat(query, separator)
end