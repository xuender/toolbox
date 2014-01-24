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
  input: ''
  constructor: (@scope, @name)->

  run: ->
    input = @scope.input
    this.command()
    console.debug " #{@name} run."
    if this instanceof Command and this.constructor != Command
      Command.push(@name, this)
      c = new Command(@scope, @name)
      c.input = input
      @scope.history.push(c)
    TRACKER.sendEvent('command', 'name', @name)

  command: ->
    Command.history[@name].command()

class Divider extends Command
  command: ->
    console.error 'divider not run'
