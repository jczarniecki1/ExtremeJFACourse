// Generated by CoffeeScript 1.7.1
(function() {
  var auth, challengesController, coursesController, messagesController, ratingsController, usersController;

  auth = require('./auth');

  usersController = require('../controllers/usersController');

  coursesController = require('../controllers/coursesController');

  messagesController = require('../controllers/messagesController');

  challengesController = require('../controllers/challengesController');

  ratingsController = require('../controllers/ratingsController');

  module.exports = function(app) {
    app.get('/api/users', auth.requireRole('admin'), usersController.getUsers);
    app.post('/api/users', usersController.createUser);
    app.put('/api/users', usersController.updateUser);
    app["delete"]('/api/users/:id', auth.requireRole('admin'), usersController.removeUser);
    app.get('/api/courses', coursesController.getCourses);
    app.post('/api/courses', auth.requireRole('admin'), coursesController.createCourse);
    app["delete"]('/api/courses/:id', auth.requireRole('admin'), coursesController.removeCourse);
    app.get('/api/ratings', auth.requireLogin, ratingsController.getRatings);
    app.post('/api/ratings', auth.requireLogin, ratingsController.addRating);
    app.put('/api/ratings', auth.requireLogin, ratingsController.updateRating);
    app.get('/api/user/:userId/messages', auth.requireRole('admin'), messagesController.getMessages);
    app.post('/api/user/:userId/messages', auth.requireLogin, messagesController.createMessage);
    app["delete"]('/api/user/:userId/messages/:id', auth.requireRole('admin'), messagesController.removeMessage);
    app.get('/api/courses/:courseId/challenges', challengesController.getChallenges);
    app.post('/api/courses/:courseId/challenges', auth.requireRole('admin'), challengesController.createChallenge);
    app["delete"]('/api/courses/:courseId/challenges/:id', auth.requireRole('admin'), challengesController.removeChallenge);
    app.get('/partials/*', function(req, res) {
      return res.render("../../public/app/" + req.params);
    });
    app.post('/login', auth.authenticate);
    app.post('/logout', auth.logout);
    app.all('/api/*', function(req, res) {
      return res.send(404);
    });
    app.get('*', function(req, res) {
      var _ref;
      return res.render('index', {
        bootstrappedUser: (_ref = req.user) != null ? _ref.getData() : void 0
      });
    });
    return 0;
  };

}).call(this);

//# sourceMappingURL=routes.map
