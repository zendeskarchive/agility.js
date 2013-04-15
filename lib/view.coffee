class Agility.View extends Backbone.View
  constructor: (app, options...) ->
    @app = app
    @childViews = []
    super(options...)

  appRoot: =>
    @app.$rootEl()

  render: =>
    if this.template
      this.renderTemplate(this.templateContext())

  templateContext: =>
    {}

  renderTemplate: (context) =>
    html = Agility.Template.render(this.template, context)
    this.$el.html(html)

  attachToRoot: =>
    root = this.appRoot()
    unless this.isAttachedToRoot()
      root.empty()
      root.append(this.$el)

  isAttachedToRoot: =>
    this.$el.parent().is(root)

  renderView: (selector, name, params) =>
    view = this.view(name, params)
    this.$(selector).html(view.el)
    view.render()
    view

  view: (viewClass, options) =>
    if _.isString(viewClass)
      viewClass = App.Views[viewClass]
    if viewClass?
      view = new viewClass(@app, options)
      @childViews.push(view)
      view
    else
      throw new Error("View #{name} not found")

  performDestroy: =>
    this.destroy()
    _.invoke(@childViews, "performDestroy")

  destroy: =>
    this.stopListening()
