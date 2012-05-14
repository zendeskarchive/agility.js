class Agility.Controller
  constructor: (app) ->
    @app = app
  view: (name, params) ->
    new App.Views[name](@app, params)
