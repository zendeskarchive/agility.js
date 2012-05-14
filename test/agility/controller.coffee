helper = require('../test_helper')
sinon = require('sinon')

helper.requireLib('controller')
helper.requireLib('view')

class App.Controllers.Test extends Agility.Controller

class App.Views.Test extends Agility.View

app = sinon.mock()

describe "Controller", ->

  describe "view", ->

    it "instantiates appropriate view", ->
      controller = new App.Controllers.Test(app)
      view = controller.view('Test')
      assert.equal(app, view.app)
