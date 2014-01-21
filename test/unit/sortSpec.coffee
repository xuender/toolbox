###
commandSpec.coffee
Copyright (C) 2014 ender xu <xuender@gmail.com>

Distributed under terms of the MIT license.
###
describe 'command', ->
  it 'sort', ->
    scope =
      history: []
      input: 'aa\ncc\nbb'
    s = new Sort(scope, 'Sort')
    s.run()
    expect(scope.output).toEqual('aa\nbb\ncc')

  it 'sortNumber', ->
    scope =
      history: []
      input: 'aa\n22\n110'
    s = new SortNumber(scope, 'SortNumber')
    s.run()
    expect(scope.output).toEqual('22\n110\naa')

  it 'desc', ->
    scope =
      history: []
      input: 'aa\ncc\nbb'
    s = new Desc(scope, 'Desc')
    s.run()
    expect(scope.output).toEqual('cc\nbb\naa')

  it 'descNumber', ->
    scope =
      history: []
      input: 'aa\n210\n31'
    s = new DescNumber(scope, 'Desc')
    s.run()
    expect(scope.output).toEqual('aa\n210\n31')

  it 'reverse', ->
    scope =
      history: []
      input: '33\ncc\n11'
    s = new Reverse(scope, 'reverse')
    s.run()
    expect(scope.output).toEqual('11\ncc\n33')
