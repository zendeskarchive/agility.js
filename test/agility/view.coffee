helper = require('../test_helper')
sinon = require('sinon')

helper.requireLib('view')

root = sinon.mock()
rootEl = sinon.stub()
rootEl.returns(root)
app = { $rootEl: rootEl }

class App.Views.Test extends Agility.View

describe "View", ->
	describe ".appRoot", ->
		it "returns application root element", ->
      view = new App.Views.Test(app)
      assert.equal(view.appRoot(), root)
