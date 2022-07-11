-- created by lxs7499

local resource = {}

function resource.resolveColor(resId)
  local a = activity.obtainStyledAttributes({ resId })
  local res = a.getColor(0, 0)
  a.recycle()
  return res
end

return resource
