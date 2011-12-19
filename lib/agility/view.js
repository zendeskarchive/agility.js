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
    return this;
  },
  renderInto: function(selector) {
    if (!this.rendered) this.render()
    $(selector).html(this.el)
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
