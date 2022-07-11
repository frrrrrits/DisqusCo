-- created by lxs7499

string.asTitleBar = function(self)
  string.title = self
  activity.getSupportActionBar().title = tostring(self.title)
end

string.asSubtitleBar = function(self)
  string.subtitle = self
  activity.getSupportActionBar().subtitle = tostring(self.subtitle)
end