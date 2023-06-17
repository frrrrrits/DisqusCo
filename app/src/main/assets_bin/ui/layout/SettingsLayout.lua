-- preference layout
-- created by lxs7499

import "resource"
import "rikka.widget.switchbar.SwitchBar"
import "com.google.android.material.materialswitch.MaterialSwitch"

return function()
  return {
    CoordinatorLayout,
    id = "coordinator",
    layout_width = "match_parent",
    layout_height = "match_parent",
    {
      AppBarLayout,
      layout_marginTop = "8dp",
      backgroundColor = "0",
      layout_width = "match_parent",
      layout_height = "wrap_content",
      {
        MaterialToolbar,
        title = "You're in The Settings",
        layout_width = "match_parent",
        layout_height = "wrap_content",
        layout_scrollFlags = "scroll|exitUtilCollapsed",
      },
    },
    {
      NestedScrollView,
      id = "nestedscroll",
      layout_width = "match_parent",
      layout_height = "match_parent",
      layout_behavior = "appbar_scrolling_view_behavior",
      {
        LinearLayout,
        orientation = "vertical",
        layout_margin = "10dp",
        layout_width = "match_parent",
        layout_height = "match_parent",
        {
          TextView,
          text = "Appreance",
          layout_width = "match_parent",
          layout_marginLeft = "9dp",
          layout_marginBottom = "9dp",
          textAppearance = "textAppearanceTitleLarge",
          layout_height = "wrap_content",
        },
        {
          MaterialCardView,
          layout_margin = "10dp",
          layout_width = "match_parent",
          layout_height = "match_parent",
          {
            LinearLayout,
            layout_margin = "8dp",
            padding="10dp",
            orientation = "vertical",
            layout_width = "match_parent",
            layout_height = "match_parent",
            {
              MaterialSwitch,
              id = "switchDarkMode",
              text = "Tema aplikasi gelap.",
              textAppearance = "textAppearanceTitleMedium",
              layout_width = "match_parent",
              layout_height = "wrap_content",
            },
            {
              MaterialSwitch,
              id = "switchWebDarkMode",
              text = "Paksa mode gelap untuk browser.",
              textAppearance = "textAppearanceTitleMedium",
              layout_width = "match_parent",
              layout_height = "wrap_content",
            },
          },
        },
        {
          TextView,
          text = "Advanced",
          layout_width = "match_parent",
          layout_marginLeft = "9dp",
          layout_marginTop = "9dp",
          textAppearance = "textAppearanceTitleLarge",
          layout_height = "wrap_content",
        },
        {
          LinearLayout,
          orientation="vertical",
          layout_width = "match_parent",
          layout_margin = "11dp",
          layout_height = "wrap_content",
          {
            MaterialButton,
            id = "refreshDialog",
            icon = "@drawable/ic_refresh_24dp",
            text = "Muat ulang Dialog.",
            layout_width = "wrap_content",
            layout_height = "56dp",
          },
          {
            MaterialButton,
            gravity = "start|center",
            id = "openDisqusAccount",
            icon = "@drawable/ic_user_24dp",
            text = "Buka disqus Akun.",
            layout_width = "match_parent",
            layout_marginTop = "10dp",
            layout_height = "56dp",
          },
          {
            MaterialButton,
            id = "deleteCookieCache",
            icon = "@drawable/ic_delete_24dp",
            text = "Hapus Cookie dan Cache.",
            layout_width = "wrap_content",
            layout_marginTop = "10dp",
            layout_height = "56dp",
          },
          {
            TextView,
            text = "Ini akan menghapus history dan akun yang telah login.",
            layout_width = "match_parent",
            layout_marginTop = "4dp",
            layout_marginLeft = "12dp",
            textAppearance = "textAppearanceBodySmall",
            layout_height = "wrap_content",
          },
        },
        {
          TextView,
          text = "About",
          layout_width = "match_parent",
          layout_margin = "9dp",
          textAppearance = "textAppearanceTitleLarge",
          layout_height = "wrap_content",
        },
        {
          MaterialCardView,
          layout_margin = "10dp",
          layout_width = "match_parent",
          layout_height = "match_parent",
          {
            LinearLayout,
            layout_margin = "8dp",
            orientation = "vertical",
            layout_width = "match_parent",
            layout_height = "match_parent",
            {
              TextView,
              text = "Support for web: WestManga / Kiryuu / Shinigami",
              textAppearance = "textAppearanceTitleMedium",
              layout_width = "match_parent",
              layout_margin = "10dp",
            },
            {
              TextView,
              enabled = true,
              textIsSelectable = true,
              focusable = true,
              longClickable = true,
              text = "Github: @github.com/frrrrrits",
              textAppearance = "textAppearanceTitleMedium",
              layout_width = "match_parent",
              layout_margin = "10dp",
            },
            {
              TextView,
              text = "@note: Di buat Karna Kebutuhan Pribadi.",
              textAppearance = "textAppearanceBodySmall",
              layout_width = "match_parent",
              layout_margin = "10dp",
            },
          },
        },
      },
    },
  }
end