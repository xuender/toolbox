###
index.coffee
Copyright (C) 2014 ender xu <xuender@gmail.com>

Distributed under terms of the MIT license.
###
$ ->
  $('title').text(chrome.i18n.getMessage('title'))
  $('#input').focus()
  $(window).resize(->
    doResize()
  )
  $('ol').resize(->
    doResize()
  )

doResize = ->
  $('#input').height($(document).height() - 140)

angular.module('toolbox', [
  'ui.bootstrap'
  'hotkey'
])
ToolboxCtrl = ($scope, $modal)->
  $scope.history = []
  $scope.$watch('input',(n, o)->
    $scope.inputRow = n.split('\n').length
    $scope.inputCount = n.length
  )
  $scope.input = ''
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
        new SqlBeautify($scope, chrome.i18n.getMessage('sql'))
      ]
    }
  ]
  $scope.undo = ->
    h = $scope.history.pop()
    if h
      $scope.input = h.input
    TRACKER.sendEvent('command', 'sys', 'undo')

  $scope.about = ->
    d = $modal.open
      backdrop: true
      keyboard: true
      backdropClick: true
      templateUrl: 'about.html'
      controller: 'AboutCtrl'
    TRACKER.sendEvent('command', 'sys', 'about')

  $scope.clean = ->
    $scope.history = []
    TRACKER.sendEvent('command', 'sys', 'clean')

  $scope.repeat = ->
    for i in $scope.history
      i.run()
    TRACKER.sendEvent('command', 'sys', 'repeat')

  $scope.i18n = (key)->
    chrome.i18n.getMessage(key)
  TRACKER.sendAppView('main')
  $scope.show = true

ToolboxCtrl.$inject = ['$scope', '$modal']
