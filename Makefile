all:
	make tests && make compile
tests:
	@node_modules/.bin/mocha --compilers coffee:coffee-script --reporter spec test/**/*.coffee
demo:
	node_modules/.bin/coffee -c -j example/js/agility.js lib/*.coffee
	node_modules/.bin/coffee -c -j example/js/app.js example/app.coffee
compile:
	node_modules/.bin/coffee -c -j agility.js lib/*.coffee
	
