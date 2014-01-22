###
background.coffee
Copyright (C) 2014 ender xu <xuender@gmail.com>

Distributed under terms of the MIT license.
###
chrome.app.runtime.onLaunched.addListener(->
  chrome.app.window.create('index.html',
    bounds:
      'width': 770
      'height': 660
    minWidth: 770
    minHeight: 660
  )
)
