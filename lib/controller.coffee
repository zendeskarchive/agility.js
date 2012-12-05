class Agility.Controller
  constructor: (app) ->
    @app = app
    @childViews = []
    @app.router.on('route', this.performDestroy)

  view: (name, options) ->
    view_class = App.Views[name]
    if view_class?
      view = new view_class(@app, options)
      @childViews.push(view)
      view
    else
      throw new Error("View #{name} not found")

  performDestroy: =>
    @app.router.off('route', this.performDestroy)
    this.destroy()
    _.invoke(@childViews, "performDestroy")

  destroy: =>

