Promise = require 'bluebird'
Promise.resolve require './globals'
Arda = require 'arda'


window.addEventListener 'DOMContentLoaded', ->
  App.router = new Arda.Router Arda.DefaultLayout, document.body
  # App.router.pushContext(InitContext, {maxPlayers: 8})
