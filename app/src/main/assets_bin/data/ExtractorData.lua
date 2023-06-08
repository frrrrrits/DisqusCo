-- created by lxs7499

local ExtractorData = {}
ExtractorData.data = {}

function ExtractorData.extract(disqusIdentifier, disqusShortname, webTitle)
  table.clear(ExtractorData.data)
  ExtractorData.data.disqusShortname = disqusShortname
  ExtractorData.data.disqusIdentifier = disqusIdentifier
  ExtractorData.data.webTitle = webTitle:emptyOrNill()
end

return ExtractorData
