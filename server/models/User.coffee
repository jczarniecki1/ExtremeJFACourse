mongoose = require 'mongoose'
security = require '../utilities/security'

userSchema = mongoose.Schema
  firstName:
    type:String,
    required:'{PATH} is required '

  lastName:
    type:String,
    required:'{PATH} is required '

  username:
    type:String,
    required:'{PATH} is required '
    unique: true

  salt: String
  hashed_pwd: String
  roles: [String]

userSchema.methods =
  authenticate : (passwordToMatch) ->
    this.hashed_pwd == security.hashPwd this.salt, passwordToMatch
  hasRole: (role) ->
    this.roles.indexOf(role) > -1
  getData: ->
    {
      firstName: this.firstName
      lastName: this.lastName
      username: this.username
      roles: this.roles
    }

User = mongoose.model 'User', userSchema

createDefaultUsers = ->
  User.find({}).exec (err, collection)->
    if collection.length == 0

      salt = security.createSalt()
      hash = security.hashPwd salt, 'asd'
      User.create
        firstName:'Joe'
        lastName: 'Kowalski'
        username: 'joe@pj.com'
        salt: salt
        hashed_pwd: hash
        roles: []

      salt = security.createSalt()
      hash = security.hashPwd salt, 'asd2'
      User.create
        firstName:'Joe2'
        lastName: 'Kowalski'
        username: 'joe2@pj.com'
        salt: salt
        hashed_pwd: hash
        roles: ['lab']

      salt = security.createSalt()
      hash = security.hashPwd salt, 'xxx'
      User.create
        firstName:'Grumpy'
        lastName: 'Student'
        username: 'admin'
        salt: salt
        hashed_pwd: hash
        roles: ['admin']

exports.createDefaultUsers = createDefaultUsers