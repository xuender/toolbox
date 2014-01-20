###
background.coffee
Copyright (C) 2014 ender xu <xuender@gmail.com>

Distributed under terms of the MIT license.
###
chrome.app.runtime.onLaunched.addListener(->
  chrome.app.window.create('main.html',
    'bounds':
      'width': 650
      'height': 600
  )
)

