###
unique.coffee
Copyright (C) 2014 ender xu <xuender@gmail.com>

Distributed under terms of the MIT license.
###

uniqueArray = (array)->
    ret = []
    for i in array
      b = true
      for j in ret
        if i == j
          b = false
      if b
        ret.push(i)
    ret

class Unique extends Command
  command: ->
    @scope.output = uniqueArray(@scope.input.split('\n')).join('\n')

class Repeated extends Command
  command: ->
    ret = []
    array = @scope.input.split('\n')
    for i in array
      c = 0
      for f in array
        if i == f
          c++
      if c > 1
        ret.push(i)
    @scope.output = uniqueArray(ret).join('\n')
