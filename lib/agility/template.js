Agility.Template = {
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
