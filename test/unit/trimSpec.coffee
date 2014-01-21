###
commandSpec.coffee
Copyright (C) 2014 ender xu <xuender@gmail.com>

Distributed under terms of the MIT license.
###
describe 'command', ->
  it 'trim', ->
    scope =
      history: []
      input: 'i '
    s = new Trim(scope, 'Trim')
    s.run()
    expect(scope.output).toEqual('i')

  it 'trim row', ->
    scope =
      history: []
      input: 'i \n b'
    s = new TrimRow(scope, 'TrimRow')
    s.run()
    expect(scope.output).toEqual('i\nb')

  it 'blank', ->
    scope =
      history: []
      input: 'i \n \n b'
    s = new Blank(scope, 'blank')
    s.run()
    expect(scope.output).toEqual('i \n b')
