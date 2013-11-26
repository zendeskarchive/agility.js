class Agility.ResourceCache
  constructor: (app) ->
    @app = app
    @cache = {}

  getOrStore: (namespace, id, factory) =>
    if this.has(namespace, id)
      return this.get(namespace, id)
    else
      model = factory()
      this.store(namespace, model)
      return model

  has: (namespace, model) =>
    this.get(namespace, model) != undefined

  store: (namespace, model) =>
    unless _.has(@cache, namespace)
      @cache[namespace] = new Agility.Collection
    @cache[namespace].add(model)

  get: (namespace, id) =>
    if _.has(@cache, namespace)
      @cache[namespace].get(id)

  update: (namespace, id) =>
    this.get(namespace, id)?.fetch()
