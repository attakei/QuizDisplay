# Exposed libraries to global
global.Promise   = require 'bluebird'
global.React     = require 'react/addons'
global.Arda      = require 'arda'
global.App ?= {}
global.AppComponent = require('./components/index').find
