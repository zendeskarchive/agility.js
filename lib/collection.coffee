class Agility.Collection extends Backbone.Collection
  initialize: (options) =>
    super
    @_fetched = false
    this.listenTo(this, "fetch", this._handleFetch)

  _handleFetch: =>
    @_fetched = true

  isFetched: =>
    @_fetched

  performDestroy: =>
    this.destroy()
    this.off()

  destroy: =>

