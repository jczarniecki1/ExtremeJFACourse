auth = require('./auth')
usersController = require('../controllers/usersController')
coursesController = require('../controllers/coursesController')
challengesController = require('../controllers/challengesController')

module.exports = (app)->

  app.get '/api/users', auth.requireRole('admin'), usersController.getUsers
  app.post '/api/users', usersController.createUser
  app.put '/api/users', usersController.updateUser

  app.get '/api/courses', coursesController.getCourses
  app.post '/api/courses', auth.requireRole('admin'), coursesController.createCourse
  app.delete '/api/courses/:id', auth.requireRole('admin'), coursesController.removeCourse

  app.get '/api/courses/:courseId/challenges', challengesController.getChallenges
  app.post '/api/courses/:courseId/challenges', auth.requireRole('admin'), challengesController.createChallenge

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
