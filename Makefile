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
