-- created by lxs7499

local Snack={}
setmetatable(Snack,Snack)

import "uihelper"
import "android.view.Gravity"
import "android.view.ViewGroup$LayoutParams"

-- custom snackbar
function Snack.snack(text, lengthlong, view)
  local length = Snackbar.LENGTH_SHORT

  if lengthlong == nil then
   elseif lengthlong == true then
    length = Snackbar.LENGTH_LONG
   elseif type(lengthlong) == "number" then
    length = lengthlong
  end

  local snackBar = Snackbar.make(view or window.decorView.rootView, text, length).show()
  local layoutParams = snackBar.view.layoutParams

  layoutParams.gravity = Gravity.TOP
  layoutParams.setMargins(uihelper.dp2int(10), uihelper.dp2int(120), uihelper.dp2int(10), 0)
  snackBar.view.layoutParams = layoutParams
  snackBar.view.onClick = lambda _:snackBar.dismiss()
  return snackBar
end

function Snack.__call(self, text, view, length)
  return Snack.snack(text, view, length)
end

return Snack
