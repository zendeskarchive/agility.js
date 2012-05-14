Agility.Template =
  templates: {},
  clearTemplates: ->
    this.templates = {}
  register: (name, html) ->
    this.templates[name] = Handlebars.compile(html)
  find: (name) ->
    this.templates[name]
  render: (name, data, options) ->
    template = this.find(name)
    if template
      template(data, options)
    else
      throw "Template #{name} not found"

