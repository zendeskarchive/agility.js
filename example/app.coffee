class App.Controllers.Home extends Agility.Controller
  welcome: (name) ->
    alert(name)

class ExampleApp extends Agility.Application
  root: '#root'
  routes: 
    "": "Home#welcome"
    ":name": "Home#welcome" 

$ ->
  App.instance = new ExampleApp()
  App.instance.run()

