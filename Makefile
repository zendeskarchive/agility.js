all:
	@make build && make test

build:
	@cat lib/agility.js lib/agility/*.js > agility.js
	@uglifyjs agility.js > agility.min.js

test:
	@jessie spec

setup:
	npm install jessie --global
	npm install coffee-script jsdom

coverage:
	@rm -rf tmp
	@mkdir -p tmp/raw
	@mkdir -p tmp/covered
	@cp agility.js tmp/raw/
	@sbin/jscoverage tmp/raw/ tmp/covered/
	@COVERAGE=true jessie spec
	@rm -rf tmp