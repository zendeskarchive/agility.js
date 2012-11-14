helper = require('../test_helper')
sinon = require('sinon')

helper.requireLib('view')
helper.requireLib('template')

Agility.Template.register "welcome", "Hello {{name}}"

class App.Views.Test extends Agility.View
  template: "welcome"

class App.Views.OtherTest extends Agility.View

describe "View", ->
  beforeEach ->
    @root = {
      empty: ->,
      append: ->
    }
    rootEl = sinon.stub()
    rootEl.returns(@root)
    app = { $rootEl: rootEl }
    @view = new App.Views.Test(app, { name: "Tom" })

  describe ".appRoot", ->
    it "returns application root element", ->
      assert.equal(@view.appRoot(), @root)

  describe ".render", ->
    it "renders defined template using templateContext", ->
      sinon.stub(@view, "templateContext").returns({ name: "Mike" })
      @view.render()
      assert.equal(@view.$el.text(), "Hello Mike")

    context "template property missing", ->
      it "does not render anything", ->
        @view.template = null
        @view.render()
        assert.equal(@view.$el.text(), "")


  describe ".templateContext", ->
    it "returns empty object", ->
      assert.deepEqual(@view.templateContext(), {})

  describe ".renderTemplate", ->
    it "renders html with given context", ->
      @view.renderTemplate({ name: "Tom" })
      assert.equal(@view.$el.text(), "Hello Tom")

  describe "attachToRoot", ->
    it "attaches the view element to app root", ->
      sinon.stub(@view, "appRoot").returns(@root)
      sinon.stub(@view, "isAttachedToRoot").returns(false)
      mock = sinon.mock(@root).expects('empty').once()
      mock = sinon.mock(@root).expects('append').withExactArgs(@view.$el).once()
      @view.attachToRoot()
      mock.verify()

   it "does not attach to root if element is already attached", ->
      sinon.stub(@view, "appRoot").returns(@root)
      sinon.stub(@view, "isAttachedToRoot").returns(true)
      mock = sinon.mock(@root).expects('empty').never()
      mock = sinon.mock(@root).expects('append').withExactArgs(@view.$el).never()
      @view.attachToRoot()
      mock.verify()

  describe "view", ->
    context "view class exists", ->
      beforeEach ->
        @child = @view.view('OtherTest')

      it "instantiates appropriate view", ->
        assert.instanceOf(@child, App.Views.OtherTest)

      it "passes app instance", ->
        assert.equal(@child.app, @view.app)

      it "adds child to childViews", ->
        assert.include(@view.childViews, @child)

    context "view class does not exist", ->
      it "throws an error if view is not found", ->
        callback = =>
          @view.view('Unknown')
        assert.throw callback, Error

  describe "performDestroy", ->
    it "calls destroy on self", ->
      mock = sinon.mock(@view)
      mock.expects("destroy")
      @view.performDestroy()
      mock.verify()

    it "calls performDestroy on all child views", ->
      child = @view.view('OtherTest')
      mocks = _.map(@view.childViews, (view) ->
        mock = sinon.mock(view)
        mock.expects("performDestroy")
        mock
      )
      @view.performDestroy()
      _.invoke(mocks, "verify")

  describe "destroy", ->
    it "is noop", ->
      @view.destroy()



