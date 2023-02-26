-- created by lxs7499

local Preference = {}
Preference.__index = Preference

-- return nilai dari shared data
local function gets(...) return activity.getSharedData(...) end

-- membuat shared data
local function sets(...) return activity.setSharedData(...) end

-- cek kalau nilai dari shared data sudah di buat / buat shared data
local function setsharedifnill(keys, value)
  if gets(keys) == nil then sets(keys, value) end
end

-- buat instance
local function new(key, value)
  assert(key ~= nil or value ~= nil, "cannot be nil")
  -- ketika ini di panggil akan langsung mengecek / membuat shared data
  setsharedifnill(key, value)
  local self = { key = key, value = value }
  return setmetatable(self, Preference)
end

-- implement object

-- dapatkan nilai
function Preference:get()
  return gets(self.key)
end

-- membuat data
function Preference:set(value)
  self.value = value -- perbarui nilai
  return sets(self.key, self.value)
end

return {
  create = new,
  __object = Preference
}