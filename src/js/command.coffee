###
command.coffee
Copyright (C) 2014 ender xu <xuender@gmail.com>

Distributed under terms of the MIT license.
###

class Command
  @history = {}
  @push = (name, command)->
    if name not of Command.history
      Command.history[name] = command
  constructor: (@scope, @name)->

  run: ->
    this.command()
    console.debug " #{@name} run."
    if this != Command
      Command.push(@name, this)
      @scope.history.push(new Command(@scope, @name))

  command: ->
    Command.history[@name].command()

class Sort extends Command
  command: ->
    @scope.output = @scope.input.split('\n').sort().join('\n')

class Desc extends Command
  command: ->
    @scope.output = @scope.input.split('\n').sort().reverse().join('\n')

class Trim extends Command
  command: ->
    @scope.output = $.trim(@scope.input)
