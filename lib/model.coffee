class Agility.Model extends Backbone.Model
  parse: (data) ->
    if @namespace then data[@namespace] else data
  toJSON: ->
    if @namespace
      result = {}
      result[@namespace] = this.attributes
    else
      result = this.attributes
    result
