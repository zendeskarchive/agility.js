all:
	@node_modules/.bin/mocha --compilers coffee:coffee-script --reporter list test/**/*.coffee
demo:
	coffee -c -j example/js/agility.js lib/*.coffee
	coffee -c -j example/js/app.js example/app.coffee
