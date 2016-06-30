Meteor.startup ->

  BrowserPolicy.content.allowOriginForAll '*'

  WebApp.connectHandlers.use (req, res, next) ->
    res.setHeader "Access-Control-Allow-Origin", "*"
    next()
