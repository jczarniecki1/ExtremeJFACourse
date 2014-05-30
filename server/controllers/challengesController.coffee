Course = require 'mongoose'
  .model 'Course'
Challenge = require 'mongoose'
  .model 'Challenge'

exports.getChallenges = (req, res) ->
  courseId = req.params.courseId
  args = if courseId? then { courseId: courseId } else {}
  Challenge.find(args).exec (err, collection) ->
    res.send collection

exports.createChallenge = (req, res, next) ->
  challengeData = req.body

  Course.findOne({_id:challengeData.courseId}).exec (err, course) ->

    if err?
        res.status 400
        res.send
          reason: 'Cannot find the course'

    else
      Challenge.create challengeData, (err, challenge) ->

        if err?
          res.status 400
          res.send
            reason: err.toString()

        else
          course.save (err) ->

            if err?
              res.status 400
              res.send
                reason: err.toString()

            else
              res.status 200
              res.send challenge


exports.removeChallenge = (req, res, next) ->
  id = req.params.id
  Challenge.remove({_id:id}).exec (err) ->

    unless err?
      res.status 200
      res.end()

    else
      res.status 400
      res.send
        reason: err.toString()

# TODO: updateChallenge