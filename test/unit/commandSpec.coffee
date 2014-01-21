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
    sort = new Sort(scope, 'Sort')
    sort.run()
    expect(scope.output).toEqual('aa\nbb\ncc')

