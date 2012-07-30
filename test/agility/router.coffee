helper = require('../test_helper')
sinon = require('sinon')

helper.requireLib('controller')
helper.requireLib('router')

spy = sinon.spy()

app = sinon.mock

class App.Controllers.Home extends Agility.Controller
  welcome: (foo) ->
    spy(foo)
  getApp: ->
    spy(@app)

describe "Router", ->
  it ".route"

  describe ".dispatch", ->
    router = null

    beforeEach ->
      app.restore
      router = new Agility.Router(app)

    it "calls appropriate action", ->
      router.dispatch("Home#welcome", ["foo"])
      assert.isTrue spy.withArgs("foo").calledOnce

    it "passes app to controller instance", ->
      router.dispatch("Home#getApp", [])
      assert.isTrue spy.withArgs(app).calledOnce

  describe ".on", ->
    router = null

    beforeEach ->
      app.restore
      router = new Agility.Router(app)

    it "delegates to Backbone router", ->
      event = "route"
      callback = ->
      mock = sinon.mock(router.router)
      mock.expects("on").withArgs(event, callback)
      router.on(event, callback)
      mock.verify()


  describe ".off", ->
    router = null

    beforeEach ->
      app.restore
      router = new Agility.Router(app)

    it "delegates to Backbone router", ->
      event = "route"
      callback = ->
      mock = sinon.mock(router.router)
      mock.expects("off").withArgs(event, callback)
      router.off(event, callback)
      mock.verify()


