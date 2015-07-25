Promise = require 'bluebird'
Promise.resolve require './globals'

NanaSanContext = require('./contexts/program/nanasan').NanaSanContext
MaruBatsuRule = require('./models/rules').MaruBatsuRule


programParam =
  name: '7○3✕'
  playerNames: ['テスト太郎', 'クイズ花子']
  ruleType: 'NanaSan'
  ruleParam: {toWin: 7, toLose: 3}
  rule: new MaruBatsuRule(7, 3)


window.addEventListener 'DOMContentLoaded', ->
  App.router = new Arda.Router Arda.DefaultLayout, document.body
  App.router.pushContext(NanaSanContext, programParam)
