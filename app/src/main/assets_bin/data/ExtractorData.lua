-- created by lxs7499

local ExtractorData = {}
ExtractorData.data = {}

local function isExtract(bool)
  table.clear(ExtractorData.data)
  return bool == nil == true
end

function ExtractorData.extract(disqusIdentifier, disqusShortname, webTitle)
  ExtractorData.data.isExtract = isExtract()
  ExtractorData.data.disqusShortname = disqusShortname
  ExtractorData.data.disqusIdentifier = disqusIdentifier
  ExtractorData.data.webTitle = webTitle:emptyOrNill():encodeEntity()
end

function ExtractorData.disqusEmbed(shortName, entity)
  ExtractorData.data.isExtract = isExtract(true)
  local disqusUrl = "https://disqus.com/embed/comments/?base=default&amp;f="..shortName.."&amp;"
  ExtractorData.data.disqusEmbedUrl = disqusUrl .. entity
  return disqusUrl .. entity
end

return ExtractorData
