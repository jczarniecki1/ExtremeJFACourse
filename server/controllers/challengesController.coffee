Course = require 'mongoose'
  .model 'Course'
Challenge = require 'mongoose'
  .model 'Challenge'

exports.getChallenges = (req, res) ->
  { courseId } = req.params
  args = { courseId } if courseId? else {}
  Challenge.find(args).exec (err, collection) ->
    res.send collection

exports.getChallengeById = (req, res) ->
  Challenge.findOne({_id:req.params.id}).exec (err, challenge) ->
    res.send challenge

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
          course.challenges.push challenge
          course.save (err) ->

            if err?
              res.status 400
              res.send
                reason: err.toString()

            else
              res.status 200
              res.send challenge

# TODO: updateChallenge