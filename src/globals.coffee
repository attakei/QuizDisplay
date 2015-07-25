# --------------------------------------
# Exposed libraries to global
# --------------------------------------
# Library
global.Promise   = require 'bluebird'
global.React     = require 'react/addons'
global.Arda      = require 'arda'

# Application
global.App ?= {}
global.AppComponent = require('./components/index')
