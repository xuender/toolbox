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
    if @scope.one
      @scope.input = @scope.output
    console.debug " #{@name} run."
    if this instanceof Command and this.constructor != Command
      Command.push(@name, this)
      @scope.history.push(new Command(@scope, @name))

  command: ->
    Command.history[@name].command()

class Divider extends Command

class Trim extends Command
  command: ->
    @scope.output = $.trim(@scope.input)

class TrimRow extends Command
  command: ->
    @scope.output = ($.trim(i) for i in @scope.input.split('\n')).join('\n')