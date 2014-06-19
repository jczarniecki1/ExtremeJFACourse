mongoose = require 'mongoose'
ObjectId = mongoose.Schema.Types.ObjectId

messageSchema = mongoose.Schema

  userId:
    type:     ObjectId,
    required: 'Cannot send anonymous message'

  url:
    type:     String,
    required: 'Cannot send message from unknown location'

  location:
    type:     String,
    required: 'Cannot send message from unknown location'

  created:
    type:     Date,
    default:  new Date()

  unread:
    type:     Boolean,
    default:  true

  text:
    type:     String,
    required: '{PATH} is required'

Message = mongoose.model 'Message', messageSchema