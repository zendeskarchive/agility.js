class Agility.View extends Backbone.View
  constructor: (app, options...) ->
    @app = app
    super(options...)
  appRoot: ->
    @app.$rootEl()
  render: ->
    context = _.extend({}, @options, this.extraContext())
    html = Agility.Template.render(@template, context)
    this.$el.html(html)
