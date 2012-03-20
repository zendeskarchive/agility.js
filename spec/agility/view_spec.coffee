TestView = Agility.View.extend
  render: ->
    $(this.el).html('<div id="test_view"></div>')

describe 'Agility.View', ->

  beforeEach ->
    document.body.innerHTML = '<div id="test1"></div>'

  describe "afterRender", ->

    it "runs after render is called", ->
      view = new Agility.View()
      view.afterRender = jasmine.createSpy()
      view.render()
      view.afterRender.should_have_been_called()

  describe "afterDOMReady", ->


    it "fires after an element is inserted into DOM", ->
      view = new TestView()
      spy  = jasmine.createSpy()
      view.afterDOMReady = ->
        spy()
        $('#test_view').length.should_be(1)
      view.renderInto('#test1')
      spy.should_have_been_called()

    it "fires after an element is appended to DOM", ->
      view = new TestView()
      spy  = jasmine.createSpy()
      view.afterDOMReady = ->
        spy()
        $('#test_view').length.should_be(1)
      view.appendInto('#test1')
      spy.should_have_been_called()
