// Agility 0.1.3
//
// (c) 2012-2012 Future Simple
var Agility = {
  start: function(start_point) {
    if (start_point) {
      if (!Backbone.history.started) Backbone.history.start({pushState: true, silent: true})
      Backbone.history.navigate(start_point)
      Backbone.history.loadUrl(start_point)
    } else {
      if (!Backbone.history.started) Backbone.history.start({pushState: true, silent: true})
      Backbone.history.loadUrl()
    }
    Backbone.history.started = true
  },
  bootables: [],
  boot: function(callback) {
    Agility.bootables.push(callback)
  },
  run: function run() {
    $.each(Agility.bootables, function(index, callback) {
      callback.call()
    })
  },
  hijackLinks: function() {
    $('a').live('click', function() {
      var host  = window.location.host + '/'
      var regex = new RegExp(window.location.host)
      if (regex.test(this.href)) {
        var href = this.href.split(host).pop()
        Monitor.Ajax.abortAll()
        Backbone.history.navigate(href, true)
        return false;
      }
    })
  }
}

if (window.jQuery) jQuery(Agility.run)

