Agility.Template =
  templates: {},
  clearTemplates: ->
    this.templates = {}
  register: (name, html) ->
    Handlebars.templates[name] = Handlebars.compile(html)
  find: (name) ->
    Handlebars.templates[name]
  render: (name, data, options) ->
    template = this.find(name)
    if template
      template(data, options)
    else
      throw new Error("Template #{name} not found")

