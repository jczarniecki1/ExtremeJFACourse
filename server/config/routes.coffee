auth = require('./auth')

module.exports = (app)->
  app.get '/partials/*', (req, res) ->
    res.render '../../public/app/' + req.params

  app.post '/login', auth.authenticate

  app.post '/logout', (req, res) ->
    req.logout()
    res.end()

  app.get '/', (req, res) ->
    res.render 'index',
      bootstrappedUser: if req.user then req.user.getData() else undefined
