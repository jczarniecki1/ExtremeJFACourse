passport = require('passport')

exports.authenticate = (req, res, next) ->

  req.body.username = req.body.username?.toLowerCase()

  auth = passport.authenticate 'local', (err,user) ->
    if err then next err
    else unless user
      res.send { success:false }
    else
      req.logIn user, (err) ->
        if err then next err
        else
          res.send
            success: true
            user: user.getData()

  auth req, res, next

exports.requireLogin = (req, res, next) ->
  unless req.isAuthenticated()
    res.status 404
    res.end()
  else
    next()

exports.requireRole = (role) ->
  (req, res, next) ->
    unless req.isAuthenticated() and req.user.hasRole(role)
      res.status 404
      res.end()
    else
      next()

exports.logout = (req, res) ->
  req.logout()
  res.end()
