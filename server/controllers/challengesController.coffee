mongoose = require 'mongoose'
Course = mongoose.model 'Course'
Challenge = mongoose.model 'Challenge'


exports.getChallenges = (req, res) ->
  courseId = req.params.courseId
  args = if courseId? then { courseId } else {}
  Challenge.find(args).exec (err, collection) ->
    res.SendIfPossible collection, err


exports.createChallenge = (req, res, next) ->
  challengeData = req.body

  Course.findOne({_id:challengeData.courseId}).exec (err, course) ->
    if err? then return res.SendError err, 'Cannot find the course'

    Challenge.create challengeData, (err, challenge) ->
      if err? then return res.SendError err

      course.save (err) ->
        res.SendIfPossible challenge, err


exports.removeChallenge = (req, res, next) ->
  id = req.params.id
  Challenge.remove({_id:id}).exec (err) ->
    res.SendOkIfPossible err


# TODO: updateChallenge