mongoose = require('mongoose')
Rating    = mongoose.model 'Rating'
Course    = mongoose.model 'Course'
Challenge = mongoose.model 'Challenge'

exports.getRatings = (req, res) ->
  userId =
    if req.user.hasRole('admin')
      req.body.userId
    else
      req.user._id.toString()

  Rating.find({userId}).exec (err, collection) ->
    res.send collection

exports.addRating = (req, res, next) ->
  ratingData = req.body

  ratingData.userId = req.body.userId

  model = if ratingData.type is 'course' then Course else Challenge
  model.findOne({_id: ratingData.objectId}).exec (err, element) ->

    if err?
      res.status 400
      res.send
        reason: err.toString()

    else
      ratingData.objectId = element._id
      ratingData.submitted = new Date()

      Rating.create ratingData, (err, rating) ->

        if err?
          res.status 400
          res.send
            reason: err.toString()

        else
          res.status 200
          res.send rating

exports.updateRating = (req, res, next) ->
  id = req.params.id
  Rating.findOne({_id:id}).exec (err, rating) ->

    if err?
      res.status 400
      res.send
        reason: err.toString()

    else
      rating.rating = req.body.rating
      rating.submitted = new Date()
      rating.save (err) ->

        if err?
          res.status 400
          res.send
            reason: err.toString()
        else
          res.send rating