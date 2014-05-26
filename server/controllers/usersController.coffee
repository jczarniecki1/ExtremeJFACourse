security = require '../utilities/security'
User = require 'mongoose'
  .model 'User'

exports.getUsers = (req, res) ->
  User.find({}).exec (err, collection) ->
    res.send collection

exports.createUser = (req, res, next) ->
  userData = req.body
  userData.username = userData.username.toLowerCase()
  userData.salt = security.createSalt()
  userData.hashed_pwd = security.hashPwd userData.salt, userData.password
  User.create userData, (err, user) ->

    if err?
      if err.toString().match('E11000')?
        err = new Error 'Duplicate Username'

      res.status 400
      res.send
        reason: err.toString()

    else
      req.logIn user, (err) ->
        res.send user

exports.updateUser = (req, res, next) ->
  userUpdates = req.body

  if req.user._id.toString() isnt userUpdates._id and not req.user.hasRole('admin')
    res.status 403
    res.end

  else
    req.user.username = userUpdates.username.toLowerCase()
    req.user.firstName = userUpdates.firstName
    req.user.lastName = userUpdates.lastName

    newPassword = userUpdates.password
    if newPassword and newPassword.length > 0
      userUpdates.salt = security.createSalt()
      userUpdates.hashed_pwd = security.hashPwd userUpdates.salt, newPassword

    req.user.save (err) ->
      if err?
        res.status 400
        res.send
          reason: err.toString()
      else
        res.send req.user
