# configure routing
#
app.get '/partials/*', (req, res) ->
  res.render '../../public/app/' + req.params

app.get '/', (req, res) ->
  res.render 'index'
