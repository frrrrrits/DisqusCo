-- created by lxs7499

local ExtractorData = {}
ExtractorData.data = {}

function ExtractorData.extract(disqusIdentifier, disqusShortname)
  table.clear(ExtractorData.data)
  ExtractorData.data.disqusShortname = disqusShortname
  ExtractorData.data.disqusIdentifier = disqusIdentifier
end

return ExtractorData
