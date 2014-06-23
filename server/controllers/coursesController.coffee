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


exports.startCourse = (req, res, next) ->
  courseId = req.params.id
  Course.findOne({_id:courseId}).exec (err, course) ->
    if err? then return res.SendError err

    unless course.published
      return res.SendError 'Course is not published'

    if req.user.courses.any((x) -> x._id is courseId)
      return res.SendError 'Course is already started'

    startDate = new Date()
    req.user.courses.push {id: courseId, startDate }
    req.user.save (err) ->
      res.SendIfPossible startDate, err


exports.setReady = (req, res, next) ->
  Course.findOne({_id:req.params.id}).exec (err, course) ->
    if err? then return res.SendError err
    course.readyToTest = true
    course.save (err) ->
      res.SendOkIfPossible err


exports.setNotReady = (req, res, next) ->
  Course.findOne({_id:req.params.id}).exec (err, course) ->
    if err? then return res.SendError err
    course.readyToTest = false
    course.save (err) ->
      res.SendOkIfPossible err


exports.publishCourse = (req, res, next) ->
  Course.findOne({_id:req.params.id}).exec (err, course) ->
    if err? then return res.SendError err
    course.published = true
    course.publishDate ?= new Date()
    course.save (err) ->
      res.SendOkIfPossible err


exports.unpublishCourse = (req, res, next) ->
  Course.findOne({_id:req.params.id}).exec (err, course) ->
    if err? then return res.SendError err
    course.published = false
    course.save (err) ->
      res.SendOkIfPossible err


exports.updateCourse = (req, res, next) ->
  id = req.params.id
  courseData = req.body

  Course.findOne({_id:id}).exec (err, course) ->
    if err? then return res.SendError err
    unless course? then return res.SendError "Course not found"

    course.title = courseData.title
    course.localFilePath = courseData.localFilePath
    course.localFileName = courseData.localFileName
    course.presentationUrl = courseData.presentationUrl
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