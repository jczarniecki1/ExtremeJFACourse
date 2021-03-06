// Generated by CoffeeScript 1.7.1
(function() {
  var express, passport;

  express = require('express');

  passport = require('passport');

  module.exports = function(app, config) {
    return app.configure(function() {
      app.set('views', config.rootPath + '/server/views');
      app.set('view engine', 'jade');
      app.use(express.logger('dev'));
      app.use(express.cookieParser());
      app.use(express.bodyParser());
      app.use(express.session({
        secret: 'session_Token'
      }));
      app.use(passport.initialize());
      app.use(passport.session());
      return app.use(express["static"](config.rootPath + '/public'));
    });
  };

}).call(this);

//# sourceMappingURL=express.map
