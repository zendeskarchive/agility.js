helper = require('../test_helper')
sinon = require('sinon')

helper.requireLib('application')

class TestApp extends Agility.Application
	root: '#foo',
	routes:
		"foo": "Home#index"

describe "Application", ->
	app = null

	beforeEach ->
		app = new TestApp()

	describe "constructor", ->
		it "created instance gets assigned to App.instance", ->
			new_app = new TestApp()
			assert.equal(App.instance, new_app)

	describe ".run", ->
		beforeEach ->
			app.populateRoutes()

		it "calls populateRoutes", ->
			sinon.stub(app, 'init')
			mock = sinon.mock(app)
			mock.expects('populateRoutes')
			app.run()
			mock.verify()

		it "calls init", ->
			sinon.stub(app, 'populateRoutes')
			mock = sinon.mock(app)
			mock.expects('init')
			app.run()
			mock.verify()

	describe "populateRoutes", ->
		it "registers routes on the router", ->
			mock = sinon.mock(app.router)
			mock.expects("route").withArgs("foo", "Home#index")
			app.populateRoutes()
			mock.verify()

	describe ".init", ->
		beforeEach ->
			app.populateRoutes()

		it "starts the history", ->
			mock = sinon.mock(Backbone.history)
			mock.expects("start").withExactArgs({pushState: true, silent: true}).once()
			mock.expects("loadUrl").once()
			app.init()
			mock.verify()
