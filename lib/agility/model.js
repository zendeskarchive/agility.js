Agility.Model = Backbone.Model.extend({
  url: function() {
    var url = Backbone.Model.prototype.url.call(this)
    return url + '.json'
  }
})
