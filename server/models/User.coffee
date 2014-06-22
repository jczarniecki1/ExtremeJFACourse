mongoose = require 'mongoose'
security = require '../utilities/security'
Mixed = mongoose.Schema.Types.Mixed

userSchema = mongoose.Schema

  firstName:
    type:     String
    required: '{PATH} is required '

  lastName:
    type:     String
    required: '{PATH} is required '

  username:
    type:     String
    required: '{PATH} is required '
    lowercase:true
    unique:   true

  courses:
    type:     [Mixed]
    default:  []

  salt:       String
  hashed_pwd: String
  roles:      [String]

  unreadMessages:
    type:     Number
    min:      0
    default:  0

  allMessages:
    type:     Number
    min:      0
    default:  0

  ratingCount:
    type:     Number
    min:      0
    default:  0

userSchema.methods =

  authenticate : (passwordToMatch) ->
    @hashed_pwd is security.hashPwd @salt, passwordToMatch

  hasRole: (role) ->
    role in @roles

  getData: ->
    { firstName, lastName, username, roles, unreadMessages, allMessages, courses } = @
    { firstName, lastName, username, roles, unreadMessages, allMessages, courses }

User = mongoose.model 'User', userSchema

createDefaultUsers = ->
  User.find({}).exec (err, collection) ->
    if collection.length is 0

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