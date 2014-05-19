auth = require('./auth')
usersController = require('../controllers/usersController')
coursesController = require('../controllers/coursesController')

module.exports = (app)->

  app.get '/api/users', auth.requireRole('admin'), usersController.getUsers
  app.post '/api/users', usersController.createUser
  app.put '/api/users', usersController.updateUser

  app.get '/api/courses', coursesController.getCourses

  app.get '/partials/*', (req, res) ->
    res.render '../../public/app/' + req.params

  app.post '/login', auth.authenticate

  app.post '/profile', auth.authenticate

  app.post '/logout', (req, res) ->
    req.logout()
    res.end()

  app.all '/api/*', (req, res) ->
    res.send 404

  app.get '*', (req, res) ->
    res.render 'index',
      bootstrappedUser: if req.user then req.user.getData() else undefined

  0
