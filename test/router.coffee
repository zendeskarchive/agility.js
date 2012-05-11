spy = sinon.spy()  

class App.Controllers.Test extends Agility.Controller
  index: ->
    spy()

Agility.Router.route "/home", "Home#index"

describe "Router", ->
  describe "dispatcher", ->
    it "accepts a path, finds a controller and calls appropriate action", ->
      Agility.Router.dispatch("/home")
      assert


