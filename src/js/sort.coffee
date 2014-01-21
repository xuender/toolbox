###
sort.coffee
Copyright (C) 2014 ender xu <xuender@gmail.com>

Distributed under terms of the MIT license.
###

compareNumber = (a, b)->
  a = parseFloat(a) if parseFloat(a)
  b = parseFloat(b) if parseFloat(b)
  if typeof(a) == 'number' and typeof(b) == 'number'
    return a - b
  if a.toString() > b.toString() then 1 else -1

class Sort extends Command
  command: ->
    @scope.output = @scope.input.split('\n').sort().join('\n')

class SortNumber extends Command
  command: ->
    @scope.output = @scope.input.split('\n').sort(compareNumber).join('\n')

class Desc extends Command
  command: ->
    @scope.output = @scope.input.split('\n').sort().reverse().join('\n')

class DescNumber extends Command
  command: ->
    @scope.output = @scope.input.split('\n').sort(compareNumber)
      .reverse().join('\n')

class Reverse extends Command
  command: ->
    @scope.output = @scope.input.split('\n').reverse().join('\n')
