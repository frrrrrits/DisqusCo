-- created by lxs7499

require "import"
import "android.view.ViewGroup"
import "com.google.android.material.progressindicator.LinearProgressIndicator"
import "android.webkit.WebView"
import "id.lxs.disquscoment.webview.NestedWebView"

local layoutTransition = LayoutTransition()
.enableTransitionType(LayoutTransition.CHANGING)

return function()
  return {
    CoordinatorLayout,
    id = "coordinator",
    fitsSystemWindows = true,
    layout_width = "match_parent",
    layout_height = "match_parent",
    {
      AppBarLayout,
      id = "appbar",
      fitsSystemWindows = true,
      layout_width = "match_parent",
      layout_height = "wrap_content",
      {
       MaterialToolbar,
        id = "toolbar",
        layout_width = "match_parent",
        layout_height = "match_parent",
        layout_scrollFlags = "scroll",
      },
    },
    {
      NestedWebView,
      id = "webView",
      -- visibility = 4, -- gone
      layout_width = "match_parent",
      layout_height = "match_parent",
      layoutTransition = layoutTransition,
      layout_behavior = "appbar_scrolling_view_behavior",
      {
        LinearProgressIndicator,
        id="progressBar",
        layout_width = "match_parent",
        layout_height = "wrap_content",
      },    
    }
  }
end