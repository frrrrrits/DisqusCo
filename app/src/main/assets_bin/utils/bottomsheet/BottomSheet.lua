-- created by lxs7499

local BottomSheet={}
setmetatable(BottomSheet,BottomSheet)

import "utils.Theme"
import "android.util.DisplayMetrics"
import "android.view.WindowManager"
import "com.google.android.material.bottomsheet.BottomSheetDialog"
import "com.google.android.material.bottomsheet.BottomSheetBehavior"

function BottomSheet:setView(view, ids)
  self.ids = ids
  self.layout = loadlayout(view, ids)
  return self
end

function BottomSheet:bottomSheet()
  return self.bottomSheetDialog
end

function BottomSheet:dismiss()
  self.bottomSheetDialog.dismiss()
  return self
end

function BottomSheet:build()
  local viewParent = self.layout
  local bottomSheetDialog = BottomSheetDialog(self.context)
  bottomSheetDialog.setContentView(viewParent)

  local metrics = DisplayMetrics()
  activity.getWindowManager().getDefaultDisplay().getMetrics(metrics)

  local bottomSheet = bottomSheetDialog.findViewById(R.id.design_bottom_sheet) 
  local behavior = BottomSheetBehavior.from(bottomSheet)
  local layoutParams = bottomSheet.layoutParams
  
  layoutParams.height = WindowManager.LayoutParams.MATCH_PARENT 
  bottomSheet.layoutParams = layoutParams
  behavior.peekHeight = metrics.heightPixels / 2
    
  bottomSheetDialog.window.setNavigationBarColor(0)
  bottomSheetDialog.show()
  
  self.bottomSheetDialog = bottomSheetDialog
  return self
end

function BottomSheet.__call(self, context)
  self = table.clone(self)
  self.context = context
  return self
end
return BottomSheet
