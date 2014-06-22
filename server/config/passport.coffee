mongoose = require 'mongoose'
passport = require 'passport'
LocalStrategy = require('passport-local').Strategy

User = mongoose.model 'User'

module.exports = ->

  passport.use new LocalStrategy (username, password, done) ->
    User.findOne {username}
    .exec (err, user) ->
      if err?
        done null, false
      else if user?.authenticate password
        done null, user
      else
        done null, false


  passport.serializeUser (user, done) ->
    if user
      done null, user.id
    else
      done null, false



  passport.deserializeUser (id, done) ->
    User.findOne {_id:id}
    .exec (err, user) ->
      if err?
        done err, null
      else if user
        done null, user
