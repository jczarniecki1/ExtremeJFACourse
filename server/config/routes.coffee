auth = require('./auth')

module.exports = (app)->
  app.get '/partials/*', (req, res) ->
    res.render '../../public/app/' + req.params

  app.post '/login', auth.authenticate

  app.get '/', (req, res) ->
    res.render 'index'
