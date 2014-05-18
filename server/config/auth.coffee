passport = require('passport')

exports.authenticate = (req, res, next) ->

  req.body.username = req.body.username.toLowerCase()

  auth = passport.authenticate 'local', (err,user) ->
    if err
      next err
    else if !user
      res.send
        success:false
    else
      req.logIn user, (err) ->
        if err
          next err
        else
          res.send
            success: true
            user: user

  auth req, res, next

exports.requireLogin = (req, res, next) ->
  unless req.isAuthenticated()
    res.status 404
    res.end()
  else
    next()


exports.requireRole = (role) ->
  (req, res, next) ->
    unless req.isAuthenticated() && req.user.roles.indexOf(role) > -1
      res.status 404
      res.end()
    else
      next()
