class Agility.Application
  routes: {}
  constructor: ->
    @router = new Agility.Router(this)
    @resourceCache = new Agility.ResourceCache(this)

  populateRoutes: ->
    @router.route(path, method) for path, method of @routes
    this.bindNotFound()

  bindNotFound: =>
    if this.notFoundAction
      @router.route("*path", this.notFoundAction)

  preBoot: (proceed) ->
    proceed()

  run: ->
    this.preBoot(this.initApplication)

  initApplication: =>
    this.populateRoutes()
    this.initNavigation()
    this.hijackLinks()

  initNavigation: ->
    Backbone.history.start({pushState: true, silent: true})
    Backbone.history.loadUrl(this.startPoint())

  startPoint: ->
    null

  $rootEl: ->
    $(@root)

  hijackLinks: ->
    $('a').live 'click', (e) ->
      if $(this).attr('href') == '#'
        e.preventDefault()
        return
      host  = window.location.host + '/'
      regex = new RegExp(window.location.host)
      if regex.test(this.href)
        path = this.href.split(host).pop()
        path = path.replace(/^\//, '')
        Backbone.history.navigate(path, true)
        e.preventDefault()
