Course = require 'mongoose'
  .model 'Course'

exports.getCourses = (req, res) ->
  Course.find({}).exec (err, collection) ->
    res.send collection

exports.getCourseById = (req, res) ->
  Course.findOne({_id:req.params.id}).exec (err, course) ->
    res.send course

exports.createCourse = (req, res, next) ->
  courseData = req.body
  courseData.published = new Date()
  Course.create courseData, (err, course) ->

    if err
      res.status 400
      res.send
        reason: err.toString()

    else
      res.status 200
      res.send course