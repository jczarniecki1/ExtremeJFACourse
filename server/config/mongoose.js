// Generated by CoffeeScript 1.7.1
(function() {
  var challengeModel, courseModel, messageModel, mongoose, userModel;

  mongoose = require('mongoose');

  userModel = require('../models/User');

  courseModel = require('../models/Course');

  challengeModel = require('../models/Challenge');

  messageModel = require('../models/Message');

  module.exports = function(config) {
    var db;
    mongoose.connect(config.db);
    db = mongoose.connection;
    db.on('error', console.error.bind(console, 'connection error...'));
    db.once('open', function() {
      return console.log('Database opened successfully');
    });
    userModel.createDefaultUsers();
    return courseModel.createDefaultCourses();
  };

}).call(this);

//# sourceMappingURL=mongoose.map
