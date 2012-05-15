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
    unless this.isAttachedToRoot() 
      root.empty()
      root.append(this.$el)
  isAttachedToRoot: ->
    this.$el.parent().is(root)

