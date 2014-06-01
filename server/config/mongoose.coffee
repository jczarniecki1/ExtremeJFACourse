mongoose = require 'mongoose'
userModel = require '../models/User'
courseModel = require '../models/Course'
require '../models/Challenge'
require '../models/Message'
require '../models/Rating'

module.exports = (config)->
  mongoose.connect config.db
  db = mongoose.connection
  db.on 'error', console.error.bind(console,'connection error...')
  db.once 'open', ->
    console.log 'Database opened successfully'

  userModel.createDefaultUsers()
  courseModel.createDefaultCourses()
