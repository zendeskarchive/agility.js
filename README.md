# agility.js - a wrapper around Backbone

agility.js is a wrapper which provides some conventions and solutions which
streamline development of Backbone applications.

This is a very early build, docs are missing, but incoming.

Development
-----------

Make sure you have node and npm installed. Clone the repo and run:

```
make setup
```

To run the build and test, simply run:

```
make
```

Backbone extensions
-------------------
```
  Application
    constructor
      ✓ instantiates router with app
    .run
      ✓ calls preBoot with initApplication callback
    .preBoot
      ✓ calls passed callback
    .initApplication
      ✓ calls populateRoutes
      ✓ calls initNavigation
      ✓ calls hijackLinks
    populateRoutes
      ✓ registers routes on the router
    .initNavigation
      ✓ starts the history
    .startPoint
      ✓ returns null by default
    .rootEl
      ✓ returns jQuery element from root selector
    #hijackLinks
      ✓ sends link to Backbone.history
      ✓ sends link to Backbone.history that are on the same domain
      ✓ ignores links to externals domain
      ✓ ignores links to #

  Controller
    view
      ✓ instantiates appropriate view
      ✓ throws an error if view is not found

  Agility.Model
    deserialization
      ✓ parses properly with namespace
      ✓ parses properly without namespace
    serialization
      ✓ namespaces if required
      ✓ returns normal object if no namespace required
    className
      ✓ returns the name of the model's class

  Router
    - .route
    .dispatch
      ✓ calls appropriate action
      ✓ passes app to controller instance
      ✓ dispatches route event
    events handling
      ✓ calls bound callback
      ✓ allows to unbind callback

  Template
    registering
      ✓ allows registering of a non-compiled template
    rendering
      ✓ renders a template if found
      ✓ raises an error if template is not found

  View
    ✓ does not attach to root if element is already attached
    .appRoot
      ✓ returns application root element
    .render
      ✓ renders defined template using templateContext
      template property missing
        ✓ does not render anything
    .templateContext
      ✓ returns empty object
    .renderTemplate
      ✓ renders html with given context
    attachToRoot
      ✓ attaches the view element to app root
    view
      view class passed
        ✓ instantiates passed view class
      view class exists
        ✓ instantiates appropriate view
        ✓ passes app instance
        ✓ adds child to childViews
      view class does not exist
        ✓ throws an error if view is not found
    renderView
      ✓ instantiates correct view and puts it to selected element
    appendView
      ✓ instantiates correct view and appends it to selected element
    performDestroy
      ✓ calls destroy on self
      ✓ calls performDestroy on all child views
    destroy
      ✓ calls stopListening
    .propagateEvent
      ✓ propagates the event
      ✓ propagates the event under changed name if as options is supplied
      ✓ propagates the event and the attributes passed
      ✓ propagates the event and the attributes passed event with the as option
```

Copyright
---------

Copyright (c) 2011 Future Simple Inc.
