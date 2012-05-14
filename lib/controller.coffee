class Agility.Controller
  constructor: (app) ->
    @app = app
  view: (name, params) ->
    view_class = App.Views[name] 
    if view_class?
      new view_class(@app, params)
    else
      throw new Error("View #{name} not found")
