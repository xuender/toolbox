###
beautify.coffee
Copyright (C) 2014 ender xu <xuender@gmail.com>

Distributed under terms of the MIT license.
###

repeatStr = (s, count)->
  new Array(count + 1).join(s)

formatJson = (json)->
  i = 0
  tab = "    "
  newJson = ""
  indentLevel = 0
  inString = false
  currentChar = null
  for i in [0..json.length - 1]
    currentChar = json.charAt(i)
    switch currentChar
      when '{', '['
        if !inString
          newJson += currentChar + "\n" + repeatStr(tab, indentLevel + 1)
          indentLevel += 1
        else
          newJson += currentChar
      when '}', ']'
        if !inString
          indentLevel -= 1
          newJson += "\n" + repeatStr(tab, indentLevel) + currentChar
        else
          newJson += currentChar
      when ','
        if !inString
          newJson += ",\n" + repeatStr(tab, indentLevel)
        else
          newJson += currentChar
      when ':'
        if !inString
          newJson += ": "
        else
          newJson += currentChar
      when ' ', "\n", "\t"
        if inString
          newJson += currentChar
      when '"'
        if i > 0 and json.charAt(i - 1) != '\\'
          inString = !inString
        newJson += currentChar
      else
        newJson += currentChar
  newJson

class JsBeautify extends Command
  command: ->
    @scope.input = js_beautify(@scope.input)

class CssBeautify extends Command
  command: ->
    @scope.input = css_beautify(@scope.input)

class HtmlBeautify extends Command
  command: ->
    @scope.input = html_beautify(@scope.input)

class JsonBeautify extends Command
  command: ->
    @scope.input = formatJson(@scope.input)

class SqlBeautify extends Command
  command: ->
    @scope.input = formatSql(@scope.input)
