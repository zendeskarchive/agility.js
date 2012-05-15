class Agility.View extends Backbone.View
  constructor: (app, options...) ->
    @app = app
    super(options...)
  appRoot: ->
    @app.$rootEl()
  renderTemplate: (context) =>
    html = Agility.Template.render(@template, context)
    this.$el.html(html)
  attachToRoot: ->
    root = this.appRoot()
    root.empty()
    root.append(this.$el)
