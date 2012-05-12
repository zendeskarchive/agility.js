helper = require('../test_helper')
sinon = require('sinon')

helper.requireLib('application')
helper.requireLib('view')

spy = sinon.spy()

class TestApp extends Agility.Application
  root: '#home'

class App.Views.TestView extends Agility.View

describe "View", ->
	describe ".appRoot", ->
		it "returns application root element"

