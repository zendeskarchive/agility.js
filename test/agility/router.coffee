helper = require('../test_helper')
sinon = require('sinon')

helper.requireLib('controller')
helper.requireLib('router')

spy = sinon.spy()

class App.Controllers.Home extends Agility.Controller
	welcome: (foo) ->
		spy(foo)

describe "Router", ->
	it ".route"

	describe ".dispatch", ->
		it "accepts a path, finds a controller and calls appropriate action", ->
			router = new Agility.Router
			router.dispatch("Home#welcome", ["foo"])
			assert.isTrue spy.withArgs("foo").calledOnce
