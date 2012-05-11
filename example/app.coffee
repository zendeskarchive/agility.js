class App.Controllers.Home extends Agility.Controller
  welcome: (name) ->
    name = name or 'stranger'

class ExampleApp extends Agility.Application
  root: '#root'
  routes:
    "": "Home#welcome"
    ":name": "Home#welcome" 

$ ->
  new ExampleApp().run()
