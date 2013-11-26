global.assert = require('chai').assert
sinon = require('sinon')

jsdom = require('jsdom')
global.document = jsdom.jsdom('<html><body></body></html>')
global.window   = document.createWindow();

global.$ = require('jquery')

global._ = require("underscore")
global.Handlebars = require("handlebars")
Handlebars.templates = Handlebars.templates || {}

global.Backbone = require('backbone')
Backbone.$ = $

exports.requireLib = (name) ->
	require('../lib/' + name)

global.Agility = {}
global.App = {}
global.App.instance = {}
App.Controllers = {}
App.Views = {}
