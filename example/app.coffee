class App.Views.Welcome extends Agility.View
  constructor: (name) ->
    @name = name
  render: ->
    alert("Hello #{ @name }!")


class App.Controllers.Home extends Agility.Controller
  welcome: (name) ->
    name = name or 'stranger'
    x = this.view('Welcome', {})
    new App.Views.Welcome(name).render()


class ExampleApp extends Agility.Application
  root: '#root'
  routes:
    "": "Home#welcome"
    ":name": "Home#welcome"

$ ->
  new ExampleApp().run()
