mongoose = require 'mongoose'
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

Challenge = mongoose.model 'Challenge', challengeSchema