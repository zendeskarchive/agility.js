class Agility.Controller
  constructor: (app) ->
    @app = app
  view: (name, options) ->
    view_class = App.Views[name] 
    if view_class?
      new view_class(@app, options)
    else
      throw new Error("View #{name} not found")
