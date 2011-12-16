Backbone.old_sync = Backbone.sync

// The fact that this function is private is a disaster
// Exposing it out
Backbone.getUrl = function(object) {
  if (!(object && object.url)) return null;
  var url = _.isFunction(object.url) ? object.url() : object.url;
  return url + '.json';
};

Backbone.sync = function(method, model, options) {
  options.url = Backbone.getUrl(model);
  return Backbone.old_sync(method, model, options);
};