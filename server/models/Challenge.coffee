mongoose = require 'mongoose'
Rating   = mongoose.model 'Rating'
ObjectId = mongoose.Schema.Types.ObjectId
Mixed = mongoose.Schema.Types.Mixed

challengeLevel =
  values: 'basic advanced expert'.split(' ')
  message: 'You must choose valid level'

challengeSchema = mongoose.Schema

  title:
    type:     String
    required: '{PATH} is required'

  description:
    type:     String
    required: '{PATH} is required'

  level:
    type:     String
    enum:     challengeLevel
    required: '{PATH} is required'

  control:    String

  config:     Mixed

  courseId:   ObjectId

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