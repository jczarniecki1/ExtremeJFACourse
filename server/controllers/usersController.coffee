security = require '../utilities/security'
User = require 'mongoose'
  .model 'User'

exports.getUsers = (req, res) ->
  User.find({}).exec (err, collection) ->
    res.send collection

exports.createUser = (req, res, next) ->
  userData = req.body
  userData.username = userData.username
  userData.salt = security.createSalt()
  userData.hashed_pwd = security.hashPwd userData.salt, userData.password
  User.create userData, (err, user) ->

    if err?
      if err.toString().contains 'E11000'
        err = new Error 'Duplicate Username'

      res.status 400
      res.send
        reason: err.toString()

    else
      req.logIn user, (err) ->
        res.send user.getData()

exports.updateUser = (req, res, next) ->
  userUpdates = req.body
  req.user.username  = userUpdates.username
  req.user.firstName = userUpdates.firstName
  req.user.lastName  = userUpdates.lastName

  newPassword = userUpdates.password
  if newPassword?.length > 0
    req.user.salt = security.createSalt()
    req.user.hashed_pwd = security.hashPwd req.user.salt, newPassword

    # TODO: if password has to be changed...
    #   Log all possible parameters of this event
    #   Send email with confirmation

  req.user.save (err) ->
    if err?
      res.status 400
      res.send
        reason: err.toString()
    else
      res.send req.user.getData()

exports.removeUser = (req, res, next) ->
  id = req.params.id

  if req.user._id.toString() is id

    res.status 400
    res.send
      reason: 'You cannot remove yourself'

  else

    User.remove({_id:id}).exec (err) ->

      unless err?
        res.status 200
        res.end()

      else
        res.status 400
        res.send
          reason: err.toString()