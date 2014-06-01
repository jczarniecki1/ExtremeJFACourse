auth = require('./auth')
usersController = require('../controllers/usersController')
coursesController = require('../controllers/coursesController')
messagesController = require('../controllers/messagesController')
challengesController = require('../controllers/challengesController')

module.exports = (app)->

  app.get    '/api/users', auth.requireRole('admin'), usersController.getUsers
  app.post   '/api/users', usersController.createUser
  app.put    '/api/users', usersController.updateUser
  app.delete '/api/users/:id', auth.requireRole('admin'), usersController.removeUser

  app.get    '/api/courses', coursesController.getCourses
  app.post   '/api/courses', auth.requireRole('admin'), coursesController.createCourse
  app.delete '/api/courses/:id', auth.requireRole('admin'), coursesController.removeCourse

  app.get    '/api/user/:userId/messages', auth.requireRole('admin'), messagesController.getMessages
  app.post   '/api/user/:userId/messages', auth.requireLogin, messagesController.createMessage
#  app.post   '/api/messages', auth.requireRole('admin'), messagesController.answerMessage
  app.delete '/api/user/:userId/messages/:id', auth.requireRole('admin'), messagesController.removeMessage

  app.get    '/api/courses/:courseId/challenges', challengesController.getChallenges
  app.post   '/api/courses/:courseId/challenges', auth.requireRole('admin'), challengesController.createChallenge
  app.delete '/api/courses/:courseId/challenges/:id', auth.requireRole('admin'), challengesController.removeChallenge

  app.get '/partials/*', (req, res) ->
    res.render "../../public/app/#{req.params}"

  app.post '/login', auth.authenticate
  app.post '/logout', auth.logout

  app.all '/api/*', (req, res) -> res.send 404

  app.get '*', (req, res) ->
    res.render 'index',
      bootstrappedUser: req.user?.getData()

  0
