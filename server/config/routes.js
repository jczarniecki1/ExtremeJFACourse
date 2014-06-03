// Generated by CoffeeScript 1.7.1
(function() {
  var adminOnly, auth, challengesController, checkLogin, coursesController, messagesController, ratingsController, usersController;

  auth = require('./auth');

  usersController = require('../controllers/usersController');

  coursesController = require('../controllers/coursesController');

  messagesController = require('../controllers/messagesController');

  challengesController = require('../controllers/challengesController');

  ratingsController = require('../controllers/ratingsController');

  adminOnly = auth.requireRole('admin');

  checkLogin = auth.requireLogin;

  module.exports = function(app) {
    app.get('/api/users', adminOnly, usersController.getUsers);
    app.post('/api/users', usersController.createUser);
    app.put('/api/users', usersController.updateUser);
    app["delete"]('/api/users/:id', adminOnly, usersController.removeUser);
    app.get('/api/courses', coursesController.getCourses);
    app.post('/api/courses', adminOnly, coursesController.createCourse);
    app["delete"]('/api/courses/:id', adminOnly, coursesController.removeCourse);
    app.get('/api/ratings', checkLogin, ratingsController.getRatings);
    app.post('/api/ratings', checkLogin, ratingsController.addRating);
    app.put('/api/ratings', checkLogin, ratingsController.updateRating);
    app.get('/api/user/:userId/messages', adminOnly, messagesController.getMessages);
    app.post('/api/user/:userId/messages', checkLogin, messagesController.createMessage);
    app["delete"]('/api/user/:userId/messages/:id', adminOnly, messagesController.removeMessage);
    app.get('/api/courses/:courseId/challenges', challengesController.getChallenges);
    app.post('/api/courses/:courseId/challenges', adminOnly, challengesController.createChallenge);
    app["delete"]('/api/courses/:courseId/challenges/:id', adminOnly, challengesController.removeChallenge);
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
