// Agility 0.1.2
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

Agility.Collection = Backbone.Collection.extend({})
Agility.Controller = function(name, definition) {
  var controller = Agility.Controller.Base.extend(definition)
  Agility.Controller.controllers[name] = new controller()
};
Agility.Controller.controllers = {}

Agility.Controller.Base = Backbone.Router.extend({
  useLayout: function(name, options) {
    options = options || {}
    if (!Agility.State.layout || Agility.State.layout.name != name) {
      var layout_klass = window[Agility.Util.capitalize(name) + "LayoutView"]
      var instance      = new layout_klass(options).renderInto(Agility.root)
      Agility.State.layout = { instance: instance, name: name }
    }
    if (options.clear != false) Agility.State.layout.instance.clear()
    Agility.State.layout.instance.update(options)
    this.layout = Agility.State.layout.instance;
    return Agility.State.layout.instance
  }
})
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

Agility.Router = {
  _hook: function() {},
  executeHook: function(route, controller_name, action_name) {
    try {
      if (this._hook) this._hook(route, controller_name, action_name);
    } catch(e) {}
  },
  setHook: function(hook) {
    this._hook = hook;
  },
  route: function(route, controller_and_action) {
    if (route == '/') route = ""
    var parts           = controller_and_action.split('#');
    var controller_name = parts[0];
    var controller      = Agility.Controller.controllers[controller_name]
    if (!controller) throw new Error("Could not find controller " + controller_name);
    var action_name     = parts[1];
    var action          = controller[action_name]
    var name = controller_name + "#" + action_name
    if (!action) throw new Error("Action " + controller_name + "#" + action + " not defined");
    if (!_.isRegExp(route)) route = controller._routeToRegExp(route);
    Backbone.history || (Backbone.history = new Backbone.History);
    Backbone.history.route(route, _.bind(function(fragment) {
      Agility.Router.executeHook('/' + fragment, controller_name, action_name)
      var args = controller._extractParameters(route, fragment);
      action.apply(controller, args);
      controller.trigger.apply(controller, ['route:' + name].concat(args));
    }, controller));
  }
}
Agility.State = {}
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
};Agility.Template = {
  collection: {},
  loadAll: function() {
    var scripts = $('script[type="text/x-handlebars-template"]')
    $.each(scripts, function(index, script) {
      Agility.Template.collection[script.id.replace(/\-template/, '')] = Handlebars.compile(script.innerHTML);
    })
  },
  register: function(name, html) {
    Agility.Template.collection[name] = Handlebars.compile(html);
  },
  render: function(name, context, options) {
    return this.collection[name](context, options)
  }
}

Agility.Template.html_escape = function(variable) {
  if (typeof(variable) == 'string') {
    return variable.replace(/&/g,'&amp;').replace(/>/g,'&gt;').replace(/</g,'&lt;').replace(/"/g,'&quot;')
  } else if (typeof(variable) == 'object' && variable.html_safe) {
    return variable.html_safe
  } else {
    return variable
  }
};
Agility.Template.h = Agility.Template.html_escape;

if (window.jQuery) {
  jQuery.fn.render = function(name, options) {
    var html = Agility.Template.render(name, options)
    $(this).html(html)
  };
}

Agility.Util = {
  // http://stackoverflow.com/questions/1026069/capitalize-the-first-letter-of-string-in-javascript
  capitalize: function(string) {
    return string.charAt(0).toUpperCase() + string.slice(1);
  }
}
Agility.View = Backbone.View.extend({
  initialize: function(context) {
    this.context = context;
  },
  template: null,
  render: function() {
    if (this.template) {
      $(this.el).html(Agility.Template.render(this.template, this.context))
      this.rendered = true;
    }
    this.afterRender()
    return this;
  },
  afterRender: function() {},
  appendInto: function(selector) {
    if (!this.rendered) this.render()
    $(selector).append(this.el);
    if (this.afterDOMReady) this.afterDOMReady();
    return this;
  },
  renderInto: function(selector) {
    if (!this.rendered) this.render()
    $(selector).html(this.el)
    if (this.afterDOMReady) this.afterDOMReady();
    return this;
  },
  navigate : function(fragment, triggerRoute) {
    Backbone.history.navigate(fragment, triggerRoute);
  }
});

Agility.Layout = Agility.View.extend({
  containers: [],
  container:  {},
  clear: function() {
    var self = this;
    _.each(this.containers, function(container) {
      self.container[container] = new Agility.Layout.Container(container, self)
      self.container[container].clear();
    });
  },
  update: function(options) {
  }
})

Agility.Layout.Container = function(name, view) {
  this.view = view;
  this.el   = self.$('#container-' + name);
};

_.extend(Agility.Layout.Container.prototype, {
  insert: function() {
    var self = this;
    _.each(arguments, function(entry) {
      if (entry.renderInto) {
        entry.appendInto(self.el)
      } else if (typeof(entry) == 'string') {
        if (/template:/.test(entry)) {
          self.el.render(entry.replace(/template:/, ''))
        }
      }
    });
  },
  clear: function() {
    this.el.html('');
  }
})
