class Agility.Router
  constructor: (app) ->
    @router = new Backbone.Router
    @app = app
  route: (path, action) =>
    this.router.route path, action, (params...) =>
      this.dispatch(action, params)
  dispatch: (action, params) =>
    this.trigger("route", action)
    [controller, method] = action.split("#")
    instance = new App.Controllers[controller](@app)
    instance[method].apply(instance, params)

_.extend(Agility.Router.prototype, Backbone.Events)
