describe 'Agility.Util', ->

  describe '#capitalize', ->

    it "capitalizes a string", ->
      Agility.Util.capitalize("mike").should_be "Mike"
    it "capitalizes a string with spaces", ->
      Agility.Util.capitalize("mike foo").should_be "Mike foo"


