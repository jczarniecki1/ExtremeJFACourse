passport = require 'passport'
User = require('mongoose').model 'User'

exports.authenticate = (req, res, next) ->

  username = req.body.username = req.body.username?.toLowerCase()

  auth = passport.authenticate 'local', (err, user) ->
    if err then next err
    else unless user
      User.findOne {username}
      .exec (err, user) ->
        if user? then res.send { success: false, reason: 'password' }
        else res.send { success: false, reason: 'username' }
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
