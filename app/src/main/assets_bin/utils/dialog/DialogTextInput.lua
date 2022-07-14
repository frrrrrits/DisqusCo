-- created by Jesse205 modified by lxs7499

local DialogTextInput = {}
setmetatable(DialogTextInput, DialogTextInput)

import "com.google.android.material.dialog.MaterialAlertDialogBuilder"
import "android.view.inputmethod.InputMethodManager"

inputMethodService = activity.getSystemService(Context.INPUT_METHOD_SERVICE)

local EmptyStr = "Gaboleh kosong."
local MustHttp = "Url invalid."

local function toboolean(b)
  if b then
    return true
   else
    return false
  end
end

local function layout(ids, self)
  local matchParent = ViewGroup.LayoutParams.MATCH_PARENT
  local wrapContent = ViewGroup.LayoutParams.WRAP_CONTENT

  ids.inputLayout = TextInputLayout(self.context)
  ids.editText = TextInputEditText(ids.inputLayout.context)
  ids.inputLayout.layoutParams = LinearLayout.LayoutParams(matchParent, matchParent)
  ids.editText.layoutParams = LinearLayout.LayoutParams(matchParent, matchParent)

  local padding = uihelper.dp2int(24)
  ids.inputLayout.setPadding(padding, padding, padding, padding)
  ids.inputLayout.addView(ids.editText)
  ids.editText.setInputType(1)
  return ids.inputLayout
end

DialogTextInput.allowNull = true

function DialogTextInput.__call(self, context)
  self = table.clone(self)
  self.context = context
  self.checkNullButtons = {}
  return self
end

function DialogTextInput:setTitle(text)
  self.title = text
  return self
end

function DialogTextInput:setText(text)
  self.text = text
  return self
end

function DialogTextInput:setHint(text)
  self.hint = text
  return self
end

function DialogTextInput:setHelperText(text)
  self.helperText = text
  return self
end

function DialogTextInput:setAllowNull(state)
  self.allowNull = state
  return self
end

function DialogTextInput:setTextFromClipBoard()
  local text = tostring(getClipBoard())
  self.ids.editText.setText(text)
  self.ids.editText.setSelection(utf8.len(text))
end

local function setButton(self, text, func, defaultFunc, checkNull, buttonType)
  local onClick
  if func then
    function onClick()
      local dialog = self.dialog
      local text = self.ids.editText.text
      local inputLayout = self.ids.inputLayout
      if checkNull and not (self.allowNull) then
        if text == "" then
          inputLayout.setError(EmptyStr).setErrorEnabled(true)
          return true
        end
        -- if not text:startwith("http") then
        --   inputLayout.setError(MustHttp).setErrorEnabled(true)
        --   return true
        -- end
      end
      if not (func(dialog, text)) then
        inputLayout.setErrorEnabled(false)
        dialog.dismiss()
      end
    end
  end
  self[buttonType] = {text, onClick, checkNull}
  if defaultFunc then
    self.defaultFunc = onClick
  end
  return self
end

function DialogTextInput:setPositiveButton(text, func, defaultFunc, checkNull)
  return setButton(self, text, func, defaultFunc, checkNull, "positiveButton")
end

function DialogTextInput:setNeutralButton(text, func, defaultFunc, checkNull)
  return setButton(self, text, func, defaultFunc, checkNull, "neutralButton")
end

function DialogTextInput:setNegativeButton(text, func, defaultFunc, checkNull)
  return setButton(self, text, func, defaultFunc, checkNull, "negativeButton")
end

function DialogTextInput:dismiss()
  self.dialog.dismiss()
end

function DialogTextInput:show()
  local ids = {}
  self.ids = ids
  local context, checkNullButtons = self.context, self.checkNullButtons
  local positiveButton, neutralButton, negativeButton = self.positiveButton, self.neutralButton, self.negativeButton
  local text, hint, helperText = self.text, self.hint, self.helperText
  local defaultFunc = self.defaultFunc
  local dialogBuilder =
  MaterialAlertDialogBuilder(context).setTitle(self.title).setView(layout(ids, self)).setCancelable(false)

  if positiveButton then
    dialogBuilder.setPositiveButton(positiveButton[1], nil)
  end
  if neutralButton then
    dialogBuilder.setNeutralButton(neutralButton[1], nil)
  end
  if negativeButton then
    dialogBuilder.setNegativeButton(negativeButton[1], nil)
  end

  local dialog = dialogBuilder.show()
  local textState = toboolean(text == nil or text == "")

  if positiveButton then
    local button = dialog.getButton(AlertDialog.BUTTON_POSITIVE)
    if positiveButton[2] then
      button.onClick = positiveButton[2]
    end
    if positiveButton[3] then
      table.insert(checkNullButtons, button)
      if textState then
        button.setEnabled(false)
      end
    end
  end
  if neutralButton then
    local button = dialog.getButton(AlertDialog.BUTTON_NEUTRAL)
    if neutralButton[2] then
      button.onClick = neutralButton[2]
    end
    if neutralButton[3] then
      table.insert(checkNullButtons, button)
      if textState then
        button.setEnabled(false)
      end
    end
  end

  if negativeButton then
    local button = dialog.getButton(AlertDialog.BUTTON_NEGATIVE)
    if negativeButton[2] then
      button.onClick = negativeButton[2]
    end
    if negativeButton[3] then
      table.insert(checkNullButtons, button)
      if textState then
        button.setEnabled(false)
      end
    end
  end

  self.dialog = dialog

  local editText, inputLayout = ids.editText, ids.inputLayout
  editText.requestFocusFromTouch()
  inputMethodService.showSoftInput(editText, 0)
  if helperText then
    if type(helperText) == "number" then
      helperText = context.getString(helperText)
    end
    inputLayout.setHelperText(helperText)
    inputLayout.setHelperTextEnabled(true)
  end
  if text then
    editText.setText(text)
    editText.setSelection(utf8.len(text))
  end
  if hint then
    if type(hint) == "number" then
      hint = context.getString(hint)
    end
    inputLayout.setHint(hint)
  end
  if defaultFunc then
    editText.onEditorAction = defaultFunc
  end
  if not (self.allowNull) then
    local oldErrorEnabled = textState
    editText.addTextChangedListener({
      onTextChanged = function(text, start, before, count)
        text = tostring(text)
        if text == "" and not (oldErrorEnabled) then
          inputLayout.setError(EmptyStr).setErrorEnabled(true)
          oldErrorEnabled = true
          for index, content in ipairs(checkNullButtons) do
            content.setEnabled(false)
          end
          return
          -- elseif not text:startwith("https://") or text:startwith("http://") and not (oldErrorEnabled) then
          -- inputLayout.setError(MustHttp).setErrorEnabled(true)
          -- oldErrorEnabled = true
          -- for index, content in ipairs(checkNullButtons) do
          --  content.setEnabled(false)
          -- end
          -- return
         elseif oldErrorEnabled then
          inputLayout.setErrorEnabled(false)
          oldErrorEnabled = false
          for index, content in ipairs(checkNullButtons) do
            content.setEnabled(true)
          end
        end
      end
    })
  end
  return dialog
end

return DialogTextInput