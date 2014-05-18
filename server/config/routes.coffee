auth = require('./auth')
mongoose = require 'mongoose'

User = mongoose.model 'User'

module.exports = (app)->

  app.get '/api/users', auth.requireRole('admin'), (req, res) ->
    User.find({}).exec (err, collection) ->
      res.send collection

  app.get '/partials/*', (req, res) ->
    res.render '../../public/app/' + req.params

  app.post '/login', auth.authenticate

  app.post '/logout', (req, res) ->
    req.logout()
    res.end()

  app.get '*', (req, res) ->
    res.render 'index',
      bootstrappedUser: if req.user then req.user.getData() else undefined

  0
