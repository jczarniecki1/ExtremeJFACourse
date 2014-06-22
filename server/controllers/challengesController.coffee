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

      course.challengesCount++
      course.save (err) ->
        res.SendIfPossible challenge, err


exports.updateChallenge = (req, res, next) ->
  id = req.params.id
  challengeData = req.body

  Challenge.findOne({_id:id}).exec (err, challenge) ->
    if err? then return res.SendError err
    unless challenge? then return res.SendError "Challenge not found"

    challenge.description = challengeData.description
    challenge.level = challengeData.level
    challenge.jsonData = challengeData.jsonData
    challenge.initialInput = challengeData.initialInput
    challenge.correctAnswerExpression = challengeData.description

    challenge.save (err) ->
      res.SendOkIfPossible err


exports.removeChallenge = (req, res, next) ->
  id = req.params.id

  Course.findOne({_id:req.params.courseId}).exec (err, course) ->
    if err? then return res.SendError err, 'Cannot find the course'

    Challenge.remove({_id:id}).exec (err) ->
      if err? then return res.SendError err

      course.challengesCount--
      course.save (err) ->
        res.SendOkIfPossible err


# TODO: updateChallenge