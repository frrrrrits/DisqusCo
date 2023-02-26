-- created by lxs7499

require "import"
import "androidx"
import "toimport"

uihelper = require "uihelper"

R = luajava.bindClass(activity.getPackageName()..".R")
aR = luajava.bindClass("com.androlua.R")

context = content or activity or service
resources = context.getResources()

if activity then
  window = activity.getWindow()
end