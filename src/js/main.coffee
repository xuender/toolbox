###
main.coffee
Copyright (C) 2014 ender xu <xuender@gmail.com>

Distributed under terms of the MIT license.
###

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
  $scope.input = ''
  $scope.output = ''
  $scope.commands = [
    {
      title: 'sort'
      items: [
        new Sort($scope, 'Sort')
        new Desc($scope, 'Desc')
      ]
    }
    {
      title: 'trim'
      items: [
        new Trim($scope, 'Trim')
      ]
    }
  ]

  $scope.clean = ->
    $scope.history = []

  $scope.repeat = ->
    for i in $scope.history
      i.command()

ToolboxCtrl.$inject = ['$scope']
