mongoose = require 'mongoose'

ratingType =
  values: 'course challenge'.split(' ')
  message: 'You can rate only existing course or challenge'

ratingSchema = mongoose.Schema

  userId:
    type:     String
    required: 'Cannot save anonymous rating'

  submitted:
    type:     Date
    required: 'Rating should have date of submission'

  type:
    type:     String
    enum:     ratingType
    required: 'Cannot send rating with unknown type'

  objectId:
    type:     Object
    required: 'Cannot save rating from unknown location'

  rating:
    type:     Number
    min:      1
    max:      5
    required: 'Cannot save rating with unknown value'

Rating = mongoose.model 'Rating', ratingSchema