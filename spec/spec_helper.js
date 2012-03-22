jessie.sugar();
var fs = require('fs');

require('coffee-script');

// Simple function to ease file loading of source files so they get loaded up in the global scope
global.include = function(filename) {
  var src = fs.readFileSync(filename);
  require('vm').runInThisContext(src, filename);
}

// jsdom
var jsdom  = require("jsdom").jsdom,
    doc    = jsdom('<html><body><body></html>'),
    window = doc.createWindow();
global.document = doc
global.window = window

// load jquery
require('./support/jquery.js');
global.$ = global.jQuery = window.$
// require('backbone');

include('spec/support/underscore.js')
include('spec/support/backbone.js')

if (process.env.COVERAGE) {
  include('tmp/covered/agility.js')
  jessie.callbacks.bind('finish', function() {
    var Coverage = require('./support/coverage')
    var report = new Coverage.Report()
    report.shortReport()
    if (process.env.LISTING) report.coverageListing()
  })
} else {
  include('agility.js')
}

