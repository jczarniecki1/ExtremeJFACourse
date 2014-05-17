passport = require('passport')

exports.authenticate = (req, res, next) ->
    auth = passport.authenticate 'local', (err,user) ->
      if err
        next err
      else if !user
        res.send
          success:false
      else
        req.logIn user, (err) ->
          if err
            next err
          else
            res.send
              success: true
              user: user

    auth req, res, next