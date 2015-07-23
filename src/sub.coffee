Promise = require 'bluebird'
Promise.resolve require './globals'

ProgressContext = require('./progress/index').ProgressContext
MaruBatsuRule = require('./models/rules').MaruBatsuRule

form =
  programName: '7○3✕'
  playerNames: ['テスト太郎', 'クイズ花子']
  rule: new MaruBatsuRule(3, 1)


window.addEventListener 'DOMContentLoaded', ->
  App.router = new Arda.Router Arda.DefaultLayout, document.body
  App.router.pushContext(ProgressContext, form)
