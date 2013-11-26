helper = require('../test_helper')
sinon = require('sinon')

helper.requireLib('resource_cache')
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

    it "instantiates cache with app", ->
      new_app = new TestApp()
      assert.equal(new_app.resourceCache.app, new_app)

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

    it "starts the history", ->
      mock = sinon.mock(Backbone.history)
      mock.expects("start").withExactArgs({pushState: true, silent: true}).once()
      mock_app = sinon.mock(app)
      start_point = sinon.mock({})
      mock_app.expects('startPoint').returns(start_point)
      mock.expects("loadUrl").withExactArgs(start_point).once()
      app.initNavigation()
      mock.verify()
      mock_app.verify()

  describe '.startPoint', ->
    it "returns null by default", ->
      assert.equal(null, app.startPoint())
  describe ".rootEl", ->
    it "returns jQuery element from root selector", ->
      root = $('<div id="foo" />')
      root.appendTo('body')
      assert.equal(app.$rootEl().get(0), root.get(0))


  describe "#hijackLinks", ->
    beforeEach ->
      # unbind live listeners
      $(document).unbind("click")
      app.hijackLinks()
      Backbone.original_history = Backbone.history
      Backbone.history = { navigate: -> }
    afterEach ->
      Backbone.history = Backbone.original_history

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
