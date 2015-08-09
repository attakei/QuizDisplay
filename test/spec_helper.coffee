# テストに必要なライブラリを先に定義する
jsdom            = require('jsdom').jsdom
global.document  = jsdom('<html><body></body></html>')
global.window    = document.defaultView
global.navigator = window.navigator

# Assert
global.assert = require 'power-assert'

# Application core
global.Promise   = require 'bluebird'
global.React     = require 'react/addons'
global.Arda      = require 'arda'
global.App ?= {}

# TODO：当面はテストでは不要なのでコメントアウト
# App.packageJson = require('json!./package.json')

