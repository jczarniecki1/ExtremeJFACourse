mongoose = require 'mongoose'
ObjectId = mongoose.Schema.Types.ObjectId

ratingType =
  values: 'course challenge'.split(' ')
  message: 'You can rate only existing course or challenge'

ratingSchema = mongoose.Schema

  userId:
    type:     ObjectId
    required: 'Cannot save anonymous rating'

  submitted:
    type:     Date
    required: 'Rating should have date of submission'

  type:
    type:     String
    enum:     ratingType
    required: 'Cannot send rating with unknown type'

  objectId:
    type:     ObjectId
    required: 'Cannot save rating from unknown location'

  value:
    type:     Number
    min:      1
    max:      5
    required: 'Cannot save rating with unknown value'

  url:
    type:     String,
    required: 'Cannot save rating from unknown location'

  location:
    type:     String,
    required: 'Cannot save rating from unknown location'

ratingSchema.methods =

  getData: ->
    { _id, submitted, type, objectId, value } = @
    { _id, submitted, type, objectId, value }

Rating = mongoose.model 'Rating', ratingSchema