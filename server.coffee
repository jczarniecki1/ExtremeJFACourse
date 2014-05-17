express = require 'express'
mongoose = require 'mongoose'
passport = require 'passport'
LocalStrategy = require('passport-local').Strategy

env = process.env.NODE_ENV = process.env.NODE_ENV || 'development'

app = express()

config = require('./server/config/config')[env]

require('./server/config/express')(app, config)

require('./server/config/mongoose')(config)

User = mongoose.model 'User'

passport.use new LocalStrategy(
  (username, password, done) ->
    User.findOne({username:username})
    .exec (err, user) ->
      if user
        done null, user
      else
        done null, false
)

passport.serializeUser (user, done) ->
  if user
    done null, user.id

passport.deserializeUser (id, done) ->
  User.findOne({_id:id})
  .exec (err, user) ->
    if user
      done null, user
    else
      done null, false

require('./server/config/routes')(app)

# start the server
#
app.listen config.port
console.log 'Listening on port ' + config.port + '...'