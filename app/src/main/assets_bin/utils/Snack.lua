-- created by lxs7499

local Snack={}
setmetatable(Snack,Snack)

function Snack.snack(text, view, lengthlong)
  local length = Snackbar.LENGTH_SHORT
  if lengthlong == nil then elseif lengthlong == true then
    length = Snackbar.LENGTH_LONG
  end
  local snackBar = Snackbar.make(view or window.decorView, text, length).show()
  return snackBar
end

function Snack.__call(self, text, view, length)
  return Snack.snack(text, view, length)
end

return Snack
