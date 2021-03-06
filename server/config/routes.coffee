auth = require './auth'
usersController       = require '../controllers/usersController'
coursesController     = require '../controllers/coursesController'
messagesController    = require '../controllers/messagesController'
challengesController  = require '../controllers/challengesController'
ratingsController     = require '../controllers/ratingsController'

adminOnly = auth.requireRole('admin')
checkLogin = auth.requireLogin

module.exports = (app)->

  app.get    '/api/users', adminOnly, usersController.getUsers
  app.post   '/api/users', usersController.createUser
  app.put    '/api/users', usersController.updateUser
  app.delete '/api/users/:id', adminOnly, usersController.removeUser

  app.get    '/api/courses', coursesController.getCourses
  app.post   '/api/courses', adminOnly, coursesController.createCourse
  app.put    '/api/courses/:id/start',     checkLogin, coursesController.startCourse
  app.put    '/api/courses/:id/update',    adminOnly, coursesController.updateCourse
  app.put    '/api/courses/:id/publish',   adminOnly, coursesController.publishCourse
  app.put    '/api/courses/:id/unpublish', adminOnly, coursesController.unpublishCourse
  app.put    '/api/courses/:id/ready',     adminOnly, coursesController.setReady
  app.put    '/api/courses/:id/notready',  adminOnly, coursesController.setNotReady
  app.delete '/api/courses/:id', adminOnly, coursesController.removeCourse

  app.get    '/api/ratings', checkLogin, ratingsController.getRatings
  app.post   '/api/ratings', checkLogin, ratingsController.addRating
  app.put    '/api/ratings', checkLogin, ratingsController.updateRating

  app.post   '/api/feedback', checkLogin, messagesController.saveFeedback

  app.get    '/api/user/:userId/messages', adminOnly, messagesController.getMessages
  app.delete '/api/user/:userId/messages/:id', adminOnly, messagesController.removeMessage

  app.get    '/api/courses/:courseId/challenges', challengesController.getChallenges
  app.post   '/api/courses/:courseId/challenges', adminOnly, challengesController.createChallenge
  app.put    '/api/courses/:courseId/challenges/:id', adminOnly, challengesController.updateChallenge
  app.delete '/api/courses/:courseId/challenges/:id', adminOnly, challengesController.removeChallenge

  app.get '/partials/*', (req, res) ->
    res.render "../../public/app/#{req.params}"

  app.post '/login', auth.authenticate
  app.post '/logout', auth.logout

  app.all '/api/*', (req, res) -> res.send 404

  app.get '*', (req, res) ->
    res.render 'index',
      bootstrappedUser: req.user?.getData()

  0
