# テストに必要なライブラリを先に定義する
jsdom            = require('jsdom').jsdom
global.document  = jsdom('<html><body></body></html>')
global.window    = document.defaultView
global.navigator = window.navigator

# Assert
global.assert = require 'power-assert'
require '../src/globals'
