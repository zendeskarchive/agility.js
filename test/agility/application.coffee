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
    it "instantiates router with app", ->
      new_app = new TestApp()
      assert.equal(new_app.router.app, new_app)

  describe ".run", ->
    it "calls preBoot with initApplication callback", ->
      app_mock = sinon.mock(app)
      app_mock.expects('preBoot').withArgs(app.initApplication).once()
      app.run()
      app_mock.verify()

  describe ".preBoot", ->
    it "calls passed callback", ->
      callback = sinon.mock().once()
      app.preBoot(callback)
      callback.verify()

  describe ".initApplication", ->
    beforeEach ->
      app.populateRoutes()

    it "calls populateRoutes", ->
      sinon.stub(app, 'initNavigation')
      sinon.stub(app, 'hijackLinks')
      mock = sinon.mock(app)
      mock.expects('populateRoutes')
      app.run()
      mock.verify()

    it "calls initNavigation", ->
      sinon.stub(app, 'populateRoutes')
      sinon.stub(app, 'hijackLinks')
      mock = sinon.mock(app)
      mock.expects('initNavigation')
      app.run()
      mock.verify()

    it "calls hijackLinks", ->
      sinon.stub(app, 'populateRoutes')
      sinon.stub(app, 'initNavigation')
      mock = sinon.mock(app)
      mock.expects('hijackLinks')
      app.run()
      mock.verify()

  describe "populateRoutes", ->
    it "registers routes on the router", ->
      mock = sinon.mock(app.router)
      mock.expects("route").withArgs("foo", "Home#index")
      app.populateRoutes()
      mock.verify()

  describe ".initNavigation", ->
    beforeEach ->
      app.populateRoutes()
      app.hijackLinks()

    it "starts the history", ->
      mock = sinon.mock(Backbone.history)
      mock.expects("start").withExactArgs({pushState: true, silent: true}).once()
      mock.expects("loadUrl").once()
      app.initNavigation()
      mock.verify()

  describe ".rootEl", ->
    it "returns jQuery element from root selector", ->
      root = $('<div id="foo" />')
      root.appendTo('body')
      assert.equal(app.$rootEl().get(0), root.get(0))


  describe "#hijackLinks", ->
    it "sends link to Backbone.history", ->
      document.body.innerHTML = '<a href="/omg">OMG</a>'
      mock = sinon.mock(Backbone.history)
      mock.expects('navigate').withExactArgs('omg', true)
      $('a').trigger('click')
      mock.verify()

    it "sends link to Backbone.history that are on the same domain", ->
      window.location.host="myapp.com"
      document.body.innerHTML = '<a href="http://myapp.com/omg">OMG</a>'
      mock = sinon.mock(Backbone.history)
      mock.expects('navigate').withExactArgs('omg', true)
      $('a').trigger('click')
      mock.verify()

    it "ignores links to externals domain", ->
      window.location.href="http://myapp.com"
      window.location.host="myapp.com"
      document.body.innerHTML = '<a href="https://google.com">OMG</a>'
      mock = sinon.mock(Backbone.history)
      mock.expects('navigate').never()
      $('a').trigger('click')
      mock.verify()

    it "ignores links to #", ->
      document.body.innerHTML = '<a href="#">OMG</a>'
      mock = sinon.mock(Backbone.history)
      mock.expects('navigate').never()
      $('a').trigger('click')
      mock.verify()
