helper = require("../test_helper")
sinon = require('sinon')

helper.requireLib('model')

class NamespacedModel extends Agility.Model
  namespace: "model"

class NormalModel extends Agility.Model

describe "Agility.Model", ->
  describe "deserialization", ->
    it "parses properly with namespace", ->
      params = { model: { name: "Foo" }}
      model = new NamespacedModel()
      parsed = model.parse(params)
      assert.equal parsed.name, "Foo"

    it "parses properly without namespace", ->
      params = { name: "Foo" }
      model = new NormalModel()
      parsed = model.parse(params)
      assert.equal parsed.name, "Foo"

  describe "serialization", ->
    it "namespaces if required", ->
      params = { model: { name: "Foo" }}
      model = new NamespacedModel(params.model)
      assert.deepEqual model.toJSON(), params

    it "returns normal object if no namespace required", ->
      params = { name: "Foo" }
      model = new NormalModel(params)
      assert.deepEqual model.toJSON(), params

  describe "className", ->
    it "returns the name of the model's class", ->
      model = new NamespacedModel()
      assert.equal model.className(), "NamespacedModel"

  describe "cache change notification", ->
    model = new NormalModel(id: 5, foo: "bar")
    cached_model = new NormalModel(id: 5, foo: "bar")

    before ->
      App.instance.resourceCache =
        has: sinon.stub().returns(true)
        get: sinon.stub().returns(cached_model)

    context "cache instantiated on app instance", ->
      it "updates cached model", ->
        model.set(foo: "baz")
        assert.deepEqual(model.attributes, cached_model.attributes)


