-- created by lxs7499

require "import"
import "android.view.ViewGroup"
import "android.webkit.WebView"
import "id.lxs.disquscoment.webview.NestedWebView"
import "com.google.android.material.progressindicator.LinearProgressIndicator"

return function()
  return {
    CoordinatorLayout,
    id = "coordinator",
    layout_width = "match_parent",
    layout_height = "match_parent",
    {
      AppBarLayout,
      id = "appbar",
      elevation = "0dp",
      liftOnScroll = false,      
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
      layout_width = "match_parent",
      layout_height = "match_parent",
      layout_behavior = "appbar_scrolling_view_behavior",
      {
        LinearProgressIndicator,
        id="progressBar",
        layout_width = "match_parent",
        layout_height = "wrap_content",
      },
    },
  }
end