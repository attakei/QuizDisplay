Promise = require 'bluebird'
Promise.resolve require './globals'

ProgressContext = require('./progress/index').ProgressContext


form =
  programName: '7○3✕'
  playerNames: ['テスト太郎', 'クイズ花子']


window.addEventListener 'DOMContentLoaded', ->
  App.router = new Arda.Router Arda.DefaultLayout, document.body
  App.router.pushContext(ProgressContext, form)
