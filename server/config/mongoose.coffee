mongoose = require 'mongoose'
security = require './security'

module.exports = (config)->
  mongoose.connect config.db
  db = mongoose.connection
  db.on 'error', console.error.bind(console,'connection error...')
  db.once 'open', ->
    console.log 'Database opened successfully'

  userSchema = mongoose.Schema
    firstName: String
    lastName: String
    username: String
    salt: String
    hashed_pwd: String
    roles: [String]

  userSchema.methods =
    authenticate : (passwordToMatch) ->
      this.hashed_pwd == security.hashPwd this.salt, passwordToMatch
    getData: ->
      {
        firstName: this.firstName
        lastName: this.lastName
        username: this.username
        roles: this.roles
      }

  User = mongoose.model 'User', userSchema

  User.find({}).exec (err, collection)->
    if collection.length == 0

      salt = security.createSalt()
      hash = security.hashPwd salt, 'asd'
      User.create
        firstName:'Joe'
        lastName: 'Kowalski'
        username: 'joe'
        salt: salt
        hashed_pwd: hash
        roles: []

      salt = security.createSalt()
      hash = security.hashPwd salt, 'asd2'
      User.create
        firstName:'Joe2'
        lastName: 'Kowalski'
        username: 'joe2'
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
