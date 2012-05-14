helper = require('../test_helper')

helper.requireLib('template')

describe 'Template', ->

  template_html = "<p>{{name}}</p>"

  beforeEach ->
    Agility.Template.clearTemplates()

  describe "registering", ->

    it "allows registering of a non-compiled template", ->
      Agility.Template.register "foo", template_html
      assert.isFunction(Agility.Template.find('foo'))

  describe "rendering", ->

    it "renders a template if found", ->
      Agility.Template.register "omg", template_html
      html = Agility.Template.render "omg", { name: "Mike" }
      expected = "<p>Mike</p>"
      assert.equal(html, expected)

    it "raises an error if template is not found", ->
      callback = () ->
        Agility.Template.render "NOT_FOUND"
      assert.throw callback


