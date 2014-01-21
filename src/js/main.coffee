###
main.coffee
Copyright (C) 2014 ender xu <xuender@gmail.com>

Distributed under terms of the MIT license.
###
$ ->
  for es in [$('span'), $('button'), $('title'), $('label'), $('a')]
    for s in es
      if s.id
        s.textContent = chrome.i18n.getMessage(s.id)

angular.module('toolbox', [
  'ui.bootstrap'
])
ToolboxCtrl = ($scope)->
  $scope.history = []
  $scope.$watch('input',(n, o)->
    $scope.inputRow = n.split('\n').length
    $scope.inputCount = n.length
  )
  $scope.$watch('output',(n, o)->
    $scope.outputRow = n.split('\n').length
    $scope.outputCount = n.length
  )
  $scope.rows = 5
  chrome.storage.sync.get((items)->
    if 'one' of items
      $scope.one = items['one']
      $scope.$apply()
    else
      $scope.one = false
  )
  $scope.$watch('one', (n, o)->
    if n
      $scope.rows = 15
    else
      $scope.rows = 5
    chrome.storage.sync.set({'one': n})
  )
  $scope.input = ''
  $scope.output = ''
  $scope.commands = [
    {
      title: chrome.i18n.getMessage('g_sort')
      items: [
        new Sort($scope, chrome.i18n.getMessage('sort'))
        new SortNumber($scope, chrome.i18n.getMessage('sortNumber'))
        new Desc($scope, chrome.i18n.getMessage('desc'))
        new DescNumber($scope, chrome.i18n.getMessage('descNumber'))
        new Divider($scope, '')
        new Reverse($scope, chrome.i18n.getMessage('reverse'))
      ]
    }
    {
      title: chrome.i18n.getMessage('g_unique')
      items: [
      ]
    }
    {
      title: chrome.i18n.getMessage('g_trim')
      items: [
        new Trim($scope, chrome.i18n.getMessage('trim'))
        new TrimRow($scope, chrome.i18n.getMessage('trim_row'))
        new Blank($scope, chrome.i18n.getMessage('blank'))
      ]
    }
    {
      title: chrome.i18n.getMessage('g_hash')
      items: [
      ]
    }
    {
      title: chrome.i18n.getMessage('g_beautify')
      items: [
      ]
    }
  ]

  $scope.clean = ->
    $scope.history = []

  $scope.repeat = ->
    for i in $scope.history
      i.run()

ToolboxCtrl.$inject = ['$scope']
