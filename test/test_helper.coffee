global.assert = require('chai').assert
sinon = require('sinon')

global.$ = require('jquery')
jsdom = require('jsdom')
global.document = jsdom.jsdom('<html><body></body></html>')

global._ = require("underscore")
global.Handlebars = require("handlebars")
Handlebars.templates = Handlebars.templates || {}

global.Backbone = require('backbone')
Backbone.setDomLibrary($)

exports.requireLib = (name) ->
	require('../lib/' + name)

global.Agility = {}
global.App = {}
App.Controllers = {}
App.Views = {}
