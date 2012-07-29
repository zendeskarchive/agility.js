helper = require("../test_helper")

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

