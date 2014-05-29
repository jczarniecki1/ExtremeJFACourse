// Generated by CoffeeScript 1.7.1
(function() {
  var auth, challengesController, coursesController, usersController;

  auth = require('./auth');

  usersController = require('../controllers/usersController');

  coursesController = require('../controllers/coursesController');

  challengesController = require('../controllers/challengesController');

  module.exports = function(app) {
    app.get('/api/users', auth.requireRole('admin'), usersController.getUsers);
    app.post('/api/users', usersController.createUser);
    app.put('/api/users', usersController.updateUser);
    app.get('/api/courses', coursesController.getCourses);
    app.post('/api/courses', auth.requireRole('admin'), coursesController.createCourse);
    app["delete"]('/api/courses/:id', auth.requireRole('admin'), coursesController.removeCourse);
    app.get('/api/courses/:courseId/challenges', challengesController.getChallenges);
    app.post('/api/courses/:courseId/challenges', auth.requireRole('admin'), challengesController.createChallenge);
    app.get('/partials/*', function(req, res) {
      return res.render('../../public/app/' + req.params);
    });
    app.post('/login', auth.authenticate);
    app.post('/profile', auth.authenticate);
    app.post('/logout', function(req, res) {
      req.logout();
      return res.end();
    });
    app.all('/api/*', function(req, res) {
      return res.send(404);
    });
    app.get('*', function(req, res) {
      return res.render('index', {
        bootstrappedUser: req.user ? req.user.getData() : void 0
      });
    });
    return 0;
  };

}).call(this);

//# sourceMappingURL=routes.map
