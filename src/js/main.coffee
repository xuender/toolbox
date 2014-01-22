###
main.coffee
Copyright (C) 2014 ender xu <xuender@gmail.com>

Distributed under terms of the MIT license.
###
tracker = null
(->
  service = analytics.getService('ice_cream_app')
  tracker = service.getTracker('UA-35761644-1')
)()
$ ->
  $('#input').focus()
  $(window).resize(->
    doResize()
  )
i18n = ->
  for es in [$('span'), $('button'), $('title'), $('label'), $('a')]
    for s in es
      if s.id
        s.textContent = chrome.i18n.getMessage(s.id)

doResize = ->
  if $('body').scope().one
    h = $(window).height() - (700 - 544)
    $('#input').height(h)
  else
    h = $(window).height() - (700 - 440)
    $('#input').height(h / 2)
    $('#output').height(h / 2)

angular.module('toolbox', [
  'ui.bootstrap'
])
ToolboxCtrl = ($scope, $modal)->
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
      doResize()
    else
      $scope.one = false
  )
  $scope.$watch('one', (n, o)->
    doResize()
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
        new Unique($scope, chrome.i18n.getMessage('unique'))
        new Repeated($scope, chrome.i18n.getMessage('Repeated'))
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
        new Md5($scope, chrome.i18n.getMessage('md5'))
        new Sha1($scope, chrome.i18n.getMessage('sha1'))
      ]
    }
    {
      title: chrome.i18n.getMessage('g_beautify')
      items: [
        new JsBeautify($scope, chrome.i18n.getMessage('js'))
        new CssBeautify($scope, chrome.i18n.getMessage('css'))
        new HtmlBeautify($scope, chrome.i18n.getMessage('html'))
        new JsonBeautify($scope, chrome.i18n.getMessage('json'))
      ]
    }
  ]
  $scope.undo = ->
    h = $scope.history.pop()
    if h
      $scope.input = h.input
      $scope.output = h.output

  $scope.about = ->
    d = $modal.open
      backdrop: true
      keyboard: true
      backdropClick: true
      templateUrl: 'about.html'
      controller: 'AboutCtrl'

  $scope.clean = ->
    $scope.history = []

  $scope.repeat = ->
    for i in $scope.history
      i.run()

  i18n()
  tracker.sendAppView('main')

ToolboxCtrl.$inject = ['$scope', '$modal']
