mongoose = require 'mongoose'

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
    type:     Object

Challenge = mongoose.model 'Challenge', challengeSchema