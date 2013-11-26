class Agility.Model extends Backbone.Model
  urlSuffix: '',

  url: ->
    super() + this.urlSuffix

  initialize: =>
    this.on("change", this.updateResourceCache)

  updateResourceCache: =>
    if App.instance && App.instance.resourceCache.has(this.className(), this.id)
      cached_instance = App.instance.resourceCache.get(this.className(), this.id)
      cached_instance.set(this.attributes)

  parse: (data) ->
    if @namespace then data[@namespace] else data

  toJSON: ->
    if @namespace
      result = {}
      result[@namespace] = this.attributes
    else
      result = this.attributes
    result

  className: ->
    this.constructor.name

