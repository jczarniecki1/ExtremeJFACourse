mongoose = require 'mongoose'
Rating   = mongoose.model 'Rating'
ObjectId = mongoose.Schema.Types.ObjectId

challengeSchema = mongoose.Schema

  description:
    type:     String,
    required: '{PATH} is required'

  body:
    type:     String,
    required: '{PATH} is required'

  score:
    type:     Number,
    required: '{PATH} is required'

  courseId:
    type:     ObjectId

  avgRating:
    type:     Number
    min:      0
    default:  0

challengeSchema.methods =
  updateRating: ->
    Rating.find({objectId:@_id}).exec (err, collection) =>
      unless err?
        @avgRating = collection.avg (x) -> x.value
        @save()

Challenge = mongoose.model 'Challenge', challengeSchema