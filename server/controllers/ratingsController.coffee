mongoose = require('mongoose')
Rating    = mongoose.model 'Rating'
Course    = mongoose.model 'Course'
Challenge = mongoose.model 'Challenge'
Challenge = mongoose.model 'Challenge'
ObjectId = mongoose.Schema.Types.ObjectId

exports.getRatings = (req, res) ->
  userId =
    if req.user.hasRole 'admin'
      req.url.match(///=.*///)[0].substr(1)
      #req.body.userId
    else
      req.user._id

  Rating.find({userId}).exec (err, collection) ->
    res.send collection.map (x) -> x.getData()

exports.addRating = (req, res, next) ->
  ratingData = req.body

  ratingData.userId = req.user._id

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
          req.user.ratingCount++;
          req.user.save()
          res.send rating.getData()

exports.updateRating = (req, res, next) ->
  Rating.findOne({_id:req.body._id}).exec (err, rating) ->

    if err?
      res.status 400
      res.send
        reason: err.toString()

    else
      rating.value = req.body.value
      rating.submitted = new Date()
      rating.save (err) ->

        if err?
          res.status 400
          res.send
            reason: err.toString()
        else
          res.send rating.getData()