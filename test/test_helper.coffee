global.assert = require('chai').assert

global.Backbone = require('backbone')

exports.requireLib = (name) ->
	require('../lib/' + name)

global.Agility = {}
global.App = {}
App.Controllers = {}
