global.assert = require('chai').assert
sinon = require('sinon')

global.$ = require('jquery')
jsdom = require('jsdom')
global.document = jsdom.jsdom('<html><body></body></html>')

global.Backbone = require('backbone')
Backbone.setDomLibrary($)

exports.requireLib = (name) ->
	require('../lib/' + name)

global.Agility = {}
global.App = {}
App.Controllers = {}
App.Views = {}
