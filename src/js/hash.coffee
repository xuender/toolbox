###
hash.coffee
Copyright (C) 2014 ender xu <xuender@gmail.com>

Distributed under terms of the MIT license.
###
class Md5 extends Command
  command: ->
    @scope.output = CryptoJS.MD5(@scope.input).toString()

class Sha1 extends Command
  command: ->
    @scope.output = CryptoJS.SHA1(@scope.input).toString()
