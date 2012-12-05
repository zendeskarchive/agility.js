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
      app.router = router

    it "calls appropriate action", ->
      router.dispatch("Home#welcome", ["foo"])
      assert.isTrue spy.withArgs("foo").calledOnce

    it "passes app to controller instance", ->
      router.dispatch("Home#getApp", [])
      assert.isTrue spy.withArgs(app).calledOnce

    it "dispatches route event", ->
      event = "route"
      callback = sinon.spy()
      router.on(event, callback)
      router.dispatch("Home#welcome")
      assert.isTrue(callback.calledOnce)

  describe "events handling", ->
    router = null

    beforeEach ->
      app.restore
      router = new Agility.Router(app)

    it "calls bound callback", ->
      event = "route"
      callback = sinon.spy()
      router.on(event, callback)
      router.trigger(event)
      assert.isTrue(callback.calledOnce)

    it "allows to unbind callback", ->
      event = "route"
      callback = sinon.spy()
      router.on(event, callback)
      router.off(event, callback)
      router.trigger(event)
      assert.isFalse(callback.called)
