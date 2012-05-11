all:
	@node_modules/.bin/mocha --compilers coffee:coffee-script --reporter list test/**/*.coffee
