global.assert = require('assert')

global.Backbone = require('backbone')

exports.requireLib = (name) ->
	require('../lib/' + name)

exports.prepareAgility = ->
	global.Agility = {}
	global.App = {}
	App.Controllers = {}
