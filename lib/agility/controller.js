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
