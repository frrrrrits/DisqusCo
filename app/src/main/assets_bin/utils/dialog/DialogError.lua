-- created by lxs7499
-- just simple function

local DialogError={}
setmetatable(DialogError,DialogError)

import "com.google.android.material.dialog.MaterialAlertDialogBuilder"

function DialogError:message(msg)
  self.message = tostring(msg)
  return self
end

function DialogError:positiveButton(func)
  self.positiveButton = func or nil
  return self
end

function DialogError:negativeButton(func)  
  self.negativeButton = func or nil
  return self
end

function DialogError:show()
  local dialog = MaterialAlertDialogBuilder(self.context)
  .setTitle("Terjadi Kesalahan.")
  .setMessage(self.message) 
  .setPositiveButton("Mulai ulang", self.positiveButton)
  .setNegativeButton("Tutup", self.negativeButton)
  .create()
  
  self.dialog = dialog  
  self.dialog.show()
  return self
end

function DialogError.__call(self, context)
  self = table.clone(self)
  self.context = context
  return self
end

return DialogError
