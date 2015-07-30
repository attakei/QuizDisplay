Promise = require 'bluebird'
Promise.resolve require './globals'

StartupContext = require('./contexts/startup/index').StartupContext


window.addEventListener 'DOMContentLoaded', ->
  App.router = new Arda.Router Arda.DefaultLayout, document.body
  App.router.pushContext(StartupContext, {maxPlayers: 8})
