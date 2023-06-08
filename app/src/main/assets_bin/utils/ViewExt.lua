-- created by lxs7499

string.asTitleBar = function(self)
  string.title = self
  activity.getSupportActionBar()
  .title = tostring(self.title)
  return self.title
end

string.asSubtitleBar = function(self)
  string.subtitle = self
  activity.getSupportActionBar()
  .subtitle = tostring(self.subtitle)
  return self.subtitle
end

string.emptyOrNill = function(self)
  if tostring(self) == nil or self == "" then
    return "unknown"
   else return self
  end
end

function ApplyWindowInsetsListener(view, fun)
  ViewCompat.setOnApplyWindowInsetsListener(view, OnApplyWindowInsetsListener {
    onApplyWindowInsets = fun
  })
end