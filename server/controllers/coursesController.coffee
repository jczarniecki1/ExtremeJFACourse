Course = require 'mongoose'
  .model 'Course'
Challenge = require 'mongoose'
  .model 'Challenge'

exports.getCourses = (req, res) ->
  Course.find({}).exec (err, collection) ->
    res.send collection

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

exports.removeCourse = (req, res, next) ->
  id = req.params.id
  Course.remove({_id:id}).exec (err) ->

    unless err?
      Challenge.remove({courseId:id}).exec (err) ->

        unless err?
          res.status 200
          res.end()

        else
          res.status 400
          res.send
            reason: "Course was successfully removed.
              \nHowever there was a problem with its challenges:
              \n#{err.toString()}"

    else
      res.status 400
      res.send
        reason: err.toString()

