###
main.coffee
Copyright (C) 2014 ender xu <xuender@gmail.com>

Distributed under terms of the MIT license.
###

angular.module('toolbox', [
  'ui.bootstrap'
])
ToolboxCtrl = ($scope)->
  $scope.alert = ->
    console.info 'alert'

ToolboxCtrl.$inject = ['$scope']
