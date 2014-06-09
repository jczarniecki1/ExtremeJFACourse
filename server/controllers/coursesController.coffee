mongoose = require 'mongoose'
Course = mongoose.model 'Course'
Challenge = mongoose.model 'Challenge'

exports.getCourses = (req, res) ->
  Course.find({}).exec (err, collection) ->
    res.SendIfPossible collection, err


exports.createCourse = (req, res, next) ->
  courseData = req.body
  courseData.published = new Date()

  Course.create courseData, (err, course) ->
    res.SendIfPossible course, err


exports.removeCourse = (req, res, next) ->
  id = req.params.id

  Course.remove({_id:id}).exec (err) ->
    if err? then return res.SendError err

    Challenge.remove({courseId:id}).exec (err) ->
      res.SendOkIfPossible err
