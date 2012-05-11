helper = require('../test_helper')
sinon = require('sinon')

helper.prepareAgility()
helper.requireLib('application')

class TestApp extends Agility.Application
  root: '#foo',
  routes:
    "foo": "Home#index"

describe "Application", ->
  app = null

  beforeEach ->
    app = new TestApp()

  describe "run", ->
    for method in ['init', 'populatesRoutes'] 
      do (method) ->
        it "calls " + method, ->
          mock = sinon.mock(app)
          mock.expects(method)
          app.run()
          mock.verify()

  describe "populatesRoutes", ->
    it "registers routes on the router", ->
      mock = sinon.mock(app.router)
      mock.expects("route").withArgs("foo", "Home#index")
      app.populatesRoutes()
      mock.verify()

  describe "init", ->
    it "starts the history", ->
      mock = sinon.mock(Backbone.history)
      mock.expects("start")
      app.init()
      mock.verify()

  it "starts up", ->
