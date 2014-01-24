###
uniqueSpec.coffee
Copyright (C) 2014 ender xu <xuender@gmail.com>

Distributed under terms of the MIT license.
###

describe 'unique', ->
  it 'unique', ->
    scope =
      history: []
      input: 'i\ni\ns'
    s = new Unique(scope, 'unique')
    s.run()
    expect(scope.input).toEqual('i\ns')

  it 'repeated', ->
    scope =
      history: []
      input: 'i\ni\ns'
    s = new Repeated(scope, 'repeated')
    s.run()
    expect(scope.input).toEqual('i')
