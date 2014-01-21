###
trim.coffee
Copyright (C) 2014 ender xu <xuender@gmail.com>

Distributed under terms of the MIT license.
###

class Trim extends Command
  command: ->
    @scope.output = $.trim(@scope.input)

class TrimRow extends Command
  command: ->
    @scope.output = ($.trim(i) for i in @scope.input.split('\n')).join('\n')

class Blank extends Command
  command: ->
    t = []
    for i in @scope.input.split('\n')
      s = $.trim(i)
      if s.length > 0
        t.push(i)
    @scope.output = t.join('\n')
