// Generated by CoffeeScript 1.7.1
(function() {
  var auth, usersController;

  auth = require('./auth');

  usersController = require('../controllers/usersController');

  module.exports = function(app) {
    app.get('/api/users', auth.requireRole('admin'), usersController.getUsers);
    app.post('/api/users', usersController.createUser);
    app.put('/api/users', usersController.updateUser);
    app.get('/partials/*', function(req, res) {
      return res.render('../../public/app/' + req.params);
    });
    app.post('/login', auth.authenticate);
    app.post('/profile', auth.authenticate);
    app.post('/logout', function(req, res) {
      req.logout();
      return res.end();
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
