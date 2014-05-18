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

    if err
      if err.toString().indexOf('E11000') > -1
        err = new Error 'Duplicate Username'
      res.status 400
      res.send
        reason: err.toString()

    else
      req.logIn user, (err) ->
        res.send user