helper = require('../test_helper')
sinon = require('sinon')

helper.requireLib('view')
helper.requireLib('template')

root = sinon.mock()
rootEl = sinon.stub()
rootEl.returns(root)
app = { $rootEl: rootEl }

Agility.Template.register "welcome", "Hello {{name}}"

class App.Views.Test extends Agility.View
  template: "welcome"
  
describe "View", ->
  beforeEach ->
    @view = new App.Views.Test(app, { name: "Tom" })
  describe ".appRoot", ->
    it "returns application root element", ->
      assert.equal(@view.appRoot(), root)
  describe ".renderTemplate", ->
    it "renders html with given context", ->
      @view.renderTemplate({ name: "Tom" })
      assert.equal(@view.$el.text(), "Hello Tom")
  describe "attachToRoot", ->
    it "attaches the view element to app root", ->
      root = {
        empty: ->,
        append: ->
      }
      stub = sinon.stub(@view, "appRoot").returns(root)
      mock = sinon.mock(root).expects('empty').once()
      mock = sinon.mock(root).expects('append').withExactArgs(@view.$el).once()
      @view.attachToRoot()
      mock.verify()

