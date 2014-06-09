mongoose = require 'mongoose'
Rating   = mongoose.model 'Rating'
ObjectId = mongoose.Schema.Types.ObjectId

challengeLevel =
  values: 'basic advanced expert'.split(' ')
  message: 'You must choose valid level'

challengeSchema = mongoose.Schema

  description:
    type:     String
    required: '{PATH} is required'

  level:
    type:     String
    enum:     challengeLevel
    required: '{PATH} is required'

  jsonData:
    type:     String
    required: '{PATH} is required'

  initialInput:
    type:     String

  correctAnswerExpression:
    type:     String
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