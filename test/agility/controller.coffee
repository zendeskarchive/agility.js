helper = require('../test_helper')
sinon = require('sinon')

helper.requireLib('controller')
helper.requireLib('view')

class App.Controllers.Test extends Agility.Controller

class App.Views.Test extends Agility.View

describe "Controller", ->
  beforeEach ->
    @app = {}

    @router = {}
    @router.on = sinon.spy()
    @router.off = sinon.spy()

    @app.router = @router
    @controller = new App.Controllers.Test(@app)

  afterEach ->
    sinon.mock()

  describe "constructor", ->

    it "binds the performDestroy on the router", ->
      assert.equal(@router.on.callCount, 1)
      assert.equal(@router.on.lastCall.args[0], 'route')

  describe "view", ->
    it "instantiates appropriate view", ->
      view = @controller.view('Test')
      assert.equal(@app, view.app)

    it "throws an error if view is not found", ->
      callback = =>
        @controller.view('Unknown')
      assert.throw callback, Error

  describe "performDestroy", ->
    it "unbinds the event on the router", ->
      @controller.performDestroy()
      assert.equal(@router.off.callCount, 1)

    it "calls destroy on self", ->
      mock = sinon.mock(@controller)
      mock.expects("destroy")
      @controller.performDestroy()
      mock.verify()

    it "calls performDestroy on all child views", ->
      child = @controller.view('Test')
      mocks = _.map(@controller.childViews, (view) ->
        mock = sinon.mock(view)
        mock.expects("performDestroy")
        mock
      )
      @controller.performDestroy()
      _.invoke(mocks, "verify")

  describe "destroy", ->
    it "is noop", ->
      controller = new App.Controllers.Test(@app)
      controller.destroy()


