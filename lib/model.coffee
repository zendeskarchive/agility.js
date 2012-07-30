class Agility.Model extends Backbone.Model
  urlSuffix: '',
  url: ->
    super() + this.urlSuffix
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

