class Agility.Router
	constructor: ->
		this.router = new Backbone.Router
	route: (path, action) ->
		this.router.route path, (params...) =>
			this.dispatch(action, params)
	dispatch: (action, params) ->
		[controller, method] = action.split("#")
		instance = new App.Controllers[controller]
		instance[method].apply(instance, params)
