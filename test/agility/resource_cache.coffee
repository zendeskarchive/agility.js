helper = require("../test_helper")
sinon = require('sinon')

helper.requireLib('collection')
helper.requireLib('resource_cache')
helper.requireLib('model')

describe "Agility.ResourceCache", ->
  describe "getOrStore", ->
    context "instance not in store", ->
      it "adds function result to store and returns it", ->
        cache = new Agility.ResourceCache
        model = sinon.spy()
        result = cache.getOrStore("Deal", 5, ->
          model
        )
        assert.equal(result, model)

    context "instance in store", ->
      it "returns same instance", ->
        cache = new Agility.ResourceCache
        model = new Agility.Model(id: 5)
        another_model = new Agility.Model(id: 5)
        cache.getOrStore("Deal", 5, ->
          model
        )
        result = cache.getOrStore("Deal", 5, ->
          another_model
        )
        assert.equal(result, model)

  describe "update", ->
    it "calles fetch on found instance", ->
      cache = new Agility.ResourceCache
      model = new Agility.Model(id: 5)
      spy = sinon.stub(model, "fetch")
      cache.getOrStore("Deal", 5, ->
        model
      )
      cache.update("Deal", 5)
      assert(spy.calledOnce)
