// Generated by CoffeeScript 1.7.1
(function() {
  var User, createDefaultUsers, mongoose, security, userSchema,
    __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  mongoose = require('mongoose');

  security = require('../utilities/security');

  userSchema = mongoose.Schema({
    firstName: {
      type: String,
      required: '{PATH} is required '
    },
    lastName: {
      type: String,
      required: '{PATH} is required '
    },
    username: {
      type: String,
      required: '{PATH} is required ',
      lowercase: true,
      unique: true
    },
    salt: String,
    hashed_pwd: String,
    roles: [String],
    unreadMessages: {
      type: Number,
      min: 0,
      "default": 0
    },
    allMessages: {
      type: Number,
      min: 0,
      "default": 0
    }
  });

  userSchema.methods = {
    authenticate: function(passwordToMatch) {
      return this.hashed_pwd === security.hashPwd(this.salt, passwordToMatch);
    },
    hasRole: function(role) {
      return __indexOf.call(this.roles, role) >= 0;
    },
    getData: function() {
      var allMessages, firstName, lastName, roles, unreadMessages, username;
      firstName = this.firstName, lastName = this.lastName, username = this.username, roles = this.roles, unreadMessages = this.unreadMessages, allMessages = this.allMessages;
      return {
        firstName: firstName,
        lastName: lastName,
        username: username,
        roles: roles,
        unreadMessages: unreadMessages,
        allMessages: allMessages
      };
    }
  };

  User = mongoose.model('User', userSchema);

  createDefaultUsers = function() {
    return User.find({}).exec(function(err, collection) {
      var hash, salt;
      if (collection.length === 0) {
        salt = security.createSalt();
        hash = security.hashPwd(salt, 'asd');
        User.create({
          firstName: 'Joe',
          lastName: 'Kowalski',
          username: 'joe@pj.com',
          salt: salt,
          hashed_pwd: hash,
          roles: []
        });
        salt = security.createSalt();
        hash = security.hashPwd(salt, 'asd2');
        User.create({
          firstName: 'Joe2',
          lastName: 'Kowalski',
          username: 'joe2@pj.com',
          salt: salt,
          hashed_pwd: hash,
          roles: ['lab']
        });
        salt = security.createSalt();
        hash = security.hashPwd(salt, 'xxx');
        return User.create({
          firstName: 'Grumpy',
          lastName: 'Student',
          username: 'admin',
          salt: salt,
          hashed_pwd: hash,
          roles: ['admin']
        });
      }
    });
  };

  exports.createDefaultUsers = createDefaultUsers;

}).call(this);

//# sourceMappingURL=User.map
