-- created by lxs7499

local _M = {}

import "utils.Snack"
import "utils.ContextExt"
import "data.ExtractorData"
import "utils.dialog.DialogTextInput"

local fetchHandler = nil
local handler = Handler(Looper.getMainLooper())

local function loads(file) return loadfile(file)() end
local function tablempty(t) return next(t) == nil end

_M.loads = loads

-- get each extractor and add to table
local function extractorToList()
  local tbl = {}
  local astable = luajava.astable
  local directory = activity.getLuaDir() .. "/data/extractorProvider"
  local files = astable(File(directory).listFiles())
  -- clear previous table if has it
  table.clear(tbl)
  -- cuz this get call evry time
  table.foreach(files,function(index, content)
    if not(content.isDirectory()) then
      local path = string.format("%s/%s", directory, tostring(content.name))
      local attrs = {
        directory = path,
        name = loads(path).extractor.name,
        baseUrl = loads(path).extractor.baseUrl
      }
      table.insert(tbl, { file = attrs })
    end
  end)
  return tbl
end

-- find baseUrl extractor with current url
-- if they match then return [ it extractor directory ]
-- @param [url] to get the extractor or load
local function getExtractorByUrl(url)
  local tbl = {}
  local extractorList = extractorToList()
  for index, content in ipairs(extractorList) do
    local baseUrl = tostring(content.file.baseUrl)
    if url:startswith(baseUrl) then
      tbl.directory = content.file.directory
      break
    end
  end
  return tbl
end

-- actually the same with above, but this is return boolean
-- this used for webclient
function _M.checkExtractor(url)
  local ismatch = false
  local extractorList = extractorToList()
  for index, content in ipairs(extractorList) do
    local baseUrl = tostring(content.file.baseUrl)
    if url:match(baseUrl) ~= nil then
      ismatch = true
      break
    end
  end
  return ismatch
end


function _M.fetchData(url, ids, dialog)
  local utils = require "utils.webview.Utils"
  -- trying to catch error
  xpcall(function()
    local tries = 0
    local data = ExtractorData.data
    local extractor = getExtractorByUrl(url)
    if extractor.directory == nil then
      ids.loadUrl(url)
      print("Gagal Memuat Extractor.")
      return
    end
    Snack("Memuat extractor.").show()
    -- heres extractor get loaded
    loads(extractor.directory).get(url)
    fetchHandler = Runnable {
      run = function()
        tries = tries + 1
        if tries > 10 then
          print("Gagal Memuat Extractor.")
          handler.removeCallbacks(fetchHandler)
          return
        end
        -- if table empty then do looping
        if tablempty(data) then
          handler.postDelayed(fetchHandler, 600)
          return
        end
        if dialog then dialog:dismiss() end
        -- if table exist load this
        utils.loadUrl(ids, data)
        -- stop the handler
        handler.removeCallbacks(fetchHandler)
        return false
      end
    }
    -- run handler
    handler.post(fetchHandler)
  end, function(err)
    print("Terjadi kesalahan: " .. err)
  end)
end

function _M.createInputTextDialog(ids)
  local clipBoard = tostring(getClipBoard())
  local dialog = DialogTextInput(this)
  :setTitle("Hello!")
  :setHint("Masukan url")
  :setHelperText("help: mulai dengan https/http")
  :setAllowNull(false)

  dialog:setPositiveButton("Mulai", function(_, text)
    if text:startswith("http") then
      _M.fetchData(tostring(text), ids.webView, dialog)
      return true
    end
    print("Gagal, teks tidak mendukung.")
    return true
  end, true, true)

  dialog:setNegativeButton("Tempel", function(view, text)
    if clipBoard:startswith("http") then
      dialog:setTextFromClipBoard()
      return true
    end
    print("Gagal, teks tidak mendukung.")
    return true
  end)

  return dialog
end


function _M.__call(self)
  self = table.clone(self)
  return self
end

return _M