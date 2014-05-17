express = require 'express'
passport = require 'passport'

module.exports = (app, config)->
  app.configure ->
    app.set 'views', config.rootPath + '/server/views'
    app.set 'view engine', 'jade'
    app.use express.logger 'dev'
    app.use express.cookieParser()
    app.use express.bodyParser()
    app.use express.session
      secret: 'session_Token'

    app.use passport.initialize()
    app.use passport.session()
    app.use express.static config.rootPath + '/public'