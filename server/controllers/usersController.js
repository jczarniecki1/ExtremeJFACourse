// Generated by CoffeeScript 1.7.1
(function() {
  var User, security;

  security = require('../utilities/security');

  User = require('mongoose').model('User');

  exports.getUsers = function(req, res) {
    return User.find({}).exec(function(err, collection) {
      return res.SendIfPossible(collection, err);
    });
  };

  exports.createUser = function(req, res, next) {
    var userData;
    userData = req.body;
    userData.salt = security.createSalt();
    userData.hashed_pwd = security.hashPwd(userData.salt, userData.password);
    return User.create(userData, function(err, user) {
      if (err != null) {
        if (err.toString().contains('E11000')) {
          err = new Error('Duplicate Username');
        }
        return res.sendError(err);
      } else {
        return req.logIn(user, function(err) {
          return res.send(user.getData());
        });
      }
    });
  };

  exports.updateUser = function(req, res, next) {
    var newPassword, userUpdates;
    userUpdates = req.body;
    req.user.username = userUpdates.username;
    req.user.firstName = userUpdates.firstName;
    req.user.lastName = userUpdates.lastName;
    newPassword = userUpdates.password;
    if ((newPassword != null ? newPassword.length : void 0) > 0) {
      req.user.salt = security.createSalt();
      req.user.hashed_pwd = security.hashPwd(req.user.salt, newPassword);
    }
    return req.user.save(function(err) {
      return res.SendIfPossible(req.user.getData(), err);
    });
  };

  exports.removeUser = function(req, res, next) {
    var id;
    id = req.params.id;
    if (req.user._id.toString() === id) {
      return res.sendError('You cannot remove yourself');
    } else {
      return User.remove({
        _id: id
      }).exec(function(err) {
        return res.SendOkIfPossible(err);
      });
    }
  };

}).call(this);

//# sourceMappingURL=usersController.map
