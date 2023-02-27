-- created by lxs7499
-- just simple function

local MaterialDialog = {}
setmetatable(MaterialDialog, MaterialDialog)

import "com.google.android.material.dialog.MaterialAlertDialogBuilder"

function MaterialDialog:message(msg)
  self.message = tostring(msg)
  return self
end

function MaterialDialog:title(title)
  self.title = tostring(title)
  return self
end

function MaterialDialog:positiveButton(text, func)
  self.positiveText = text 
  self.positiveButton = func or nil
  return self
end

function MaterialDialog:negativeButton(text, func)
  self.negativeText = text
  self.negativeButton = func or nil
  return self
end

function MaterialDialog:show()
  local dialog = MaterialAlertDialogBuilder(self.context)
  .setTitle(self.title)
  .setMessage(self.message) 
  .setPositiveButton(self.positiveText, self.positiveButton)
  .setNegativeButton(self.negativeText, self.negativeButton)
  .create()
   
  self.dialog = dialog  
  self.dialog.show()
  return self
end

function MaterialDialog.__call(self, context)
  self = table.clone(self)
  self.context = context
  return self
end

return MaterialDialog
