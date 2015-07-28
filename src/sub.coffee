Promise = require 'bluebird'
Promise.resolve require './globals'

ProgressContext = require('./contexts/progress').ProgressContext
TargetRule = require('./models/rules').PointsRule


form =
  programName: '10 points'
  playerNames: ['テスト太郎', 'クイズ花子']
  rule: new TargetRule()


window.addEventListener 'DOMContentLoaded', ->
  App.router = new Arda.Router Arda.DefaultLayout, document.body
  App.router.pushContext(ProgressContext, form)
