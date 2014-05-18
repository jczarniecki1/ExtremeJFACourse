mongoose = require 'mongoose'
userModel = require '../models/User'

module.exports = (config)->
  mongoose.connect config.db
  db = mongoose.connection
  db.on 'error', console.error.bind(console,'connection error...')
  db.once 'open', ->
    console.log 'Database opened successfully'

  userModel.createDefaultUsers()
