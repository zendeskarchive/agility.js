class Agility.Collection extends Backbone.Collection
  performDestroy: =>
    this.destroy()
    this.off()

  destroy: =>

