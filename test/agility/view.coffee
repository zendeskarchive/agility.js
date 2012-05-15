helper = require('../test_helper')
sinon = require('sinon')

helper.requireLib('view')
helper.requireLib('template')

Agility.Template.register "welcome", "Hello {{name}}"

class App.Views.Test extends Agility.View
  template: "welcome"
  
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


