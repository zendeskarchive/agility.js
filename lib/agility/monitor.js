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
  },
  install: function() {
    $(document).ajaxSend(function(ev, jqxhr) {
      Monitor.Ajax.add(jqxhr)
    }).ajaxComplete(function(ev, jqxhr) {
      Monitor.Ajax.remove(jqxhr)
    })
  }
}

