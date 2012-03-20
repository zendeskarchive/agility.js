Agility.Model = Backbone.Model.extend({
  // TODO: move this to Agility.Model
  parse: function(response) {
    return this.namespace ? response[this.namespace] : response;
  },
  toJSON: function() {
    if (this.namespace) {
      result = {};
      result[this.namespace] = this.attributes;
    } else {
      result = this.attributes;
    };
    return result;
  }
})
