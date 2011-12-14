Monitor = {}
Monitor.Ajax = {
  requests: [],
  add: function(xhr) {
    this.requests.push(xhr)
  },
  remove: function(xhr) {
    var index = _.indexOf(this.requests, xhr)
    this.requests.splice(index, 1)
  },
  abortAll: function() {
    var self = this;
    _.each(this.requests, function(request) {
      request.abort()
      self.remove(request)
    })
  }
}

$(document).ajaxSend(function(ev, jqxhr) {
  Monitor.Ajax.add(jqxhr)
}).ajaxComplete(function(ev, jqxhr) {
  Monitor.Ajax.remove(jqxhr)
})

if (window.jQuery) {
  jQuery.fn.render = function(name, options) {
    var html = Agility.Template.render(name, options)
    $(this).html(html)
  };
  jQuery(Agility.run)
}

