mongoose = require 'mongoose'

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

  User = mongoose.model 'User', userSchema

  User.find({}).exec (err, collection)->
    if collection.length == 0
      User.create
        firstName:'Joe'
        lastName: 'Kowalski'
        username: 'joe'
      User.create
        firstName:'Joe2'
        lastName: 'Kowalski'
        username: 'joe2'
      User.create
        firstName:'Grumpy'
        lastName: 'Student'
        username: 'admin'
