helper = require('../test_helper')

helper.requireLib('helpers')

describe "Agility.Helpers", ->
  describe "getPath", ->
    it "returns nested value", ->
      hash = a: b: c: 'yes!'

      assert.equal(Agility.Helpers.getPath(hash, 'a.b.c'), 'yes!')
