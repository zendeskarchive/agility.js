class Agility.Application
  routes: {}
  constructor: ->
    @router = new Agility.Router()

  populatesRoutes: ->
    @router.route(path, method) for path, method of @routes

  run: ->
    this.populatesRoutes()
    this.init()

  init: ->
    Backbone.history.start()
