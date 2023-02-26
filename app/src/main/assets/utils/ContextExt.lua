-- created by lxs7499

import "android.net.Uri"
import "android.content.Intent"
import "android.content.pm.PackageManager"
import "android.content.ClipboardManager"
import "android.content.ClipboardManager$OnPrimaryClipChangedListener"

function getClipBoard()
  local clipBoardManager = context.getSystemService(Context.CLIPBOARD_SERVICE)
  return clipBoardManager.primaryClip.getItemAt(0).text  
end

function openInBrowser(uri, forceDefaultBrowser)
  xpcall(function()
    local intent = Intent(Intent.ACTION_VIEW, Uri.parse(uri))
    if forceDefaultBrowser then
      local defaultBrowser = defaultBrowserPackageName()
      intent.setPackage(defaultBrowser)
    end
    activity.startActivity(intent)
  end,
  function(err)
    print("Tidak dapat membuka browser.")
  end)
end

function defaultBrowserPackageName()
  xpcall(function()
    local browserIntent = Intent(Intent.ACTION_VIEW, Uri.parse("http://"))
    local resolveInfo = activity.packageManager.resolveActivity(browserIntent, PackageManager.MATCH_DEFAULT_ONLY)
    return resolveInfo.activityInfo.packageName
  end,
  function(err)
    print("Browser bawaan tidak di temukan.")
  end)
end