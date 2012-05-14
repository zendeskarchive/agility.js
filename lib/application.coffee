class Agility.Application
  routes: {}
  constructor: ->
    @router = new Agility.Router(this)

  populateRoutes: ->
    @router.route(path, method) for path, method of @routes

  run: ->
    this.populateRoutes()
    this.init()

  init: ->
    Backbone.history.start({pushState: true, silent: true})
    Backbone.history.loadUrl()
    this.hijackLinks()

  $rootEl: ->
    $(@root)

  hijackLinks: ->
    $('a').live 'click', (e) ->
      if $(this).attr('href') == '#'
        e.preventDefault()
        return
      host  = window.location.host + '/'
      regex = new RegExp(window.location.host)
      console.log(this.href)
      if regex.test(this.href)
        path = this.href
        path = path.replace(/^\//, '')
        Backbone.history.navigate(path, true)
        e.preventDefault()
