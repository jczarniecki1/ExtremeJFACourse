mongoose = require 'mongoose'
Course = mongoose.model 'Course'
Challenge = mongoose.model 'Challenge'

exports.getCourses = (req, res) ->
  Course.find({}).exec (err, collection) ->
    res.SendIfPossible collection, err


exports.createCourse = (req, res, next) ->
  courseData = req.body

  Course.create courseData, (err, course) ->
    res.SendIfPossible course, err


exports.publishCourse = (req, res, next) ->
  id = req.params.id

  Course.findOne({_id:id}).exec (err, course) ->
    if err? then return res.SendError err

    course.published = true
    course.publishedDate = new Date()

    course.save (err) ->
      res.SendOkIfPossible err

exports.unpublishCourse = (req, res, next) ->
  id = req.params.id

  Course.findOne({_id:id}).exec (err, course) ->
    if err? then return res.SendError err

    course.published = false

    course.save (err) ->
      res.SendOkIfPossible err

exports.updateCourse = (req, res, next) ->
  id = req.params.id
  courseData = req.body

  Course.findOne({_id:id}).exec (err, course) ->
    if err? then return res.SendError err

    course.title = courseData.title
    course.description = courseData.description
    course.tags = courseData.tags
    course.featured = courseData.featured
    course.lastUpdate = new Date()

    course.save (err) ->
      res.SendOkIfPossible err


exports.removeCourse = (req, res, next) ->
  id = req.params.id

  Course.remove({_id:id}).exec (err) ->
    if err? then return res.SendError err

    Challenge.remove({courseId:id}).exec (err) ->
      res.SendOkIfPossible err
