describe 'Agility', ->

  beforeEach ->
    Agility.bootables = []

  it "allows adding of bootables", ->
    func = ->
    Agility.boot(func)
    Agility.bootables.should_be [func]

  it "allows runs the bootables on run", ->
    func = jasmine.createSpy()
    Agility.boot(func)
    Agility.run()
    func.should_have_been_called()

  it "hijacks links" 

  it "starts Backbone history on start"

