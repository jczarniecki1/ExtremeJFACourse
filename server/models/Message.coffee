mongoose = require 'mongoose'

messageSchema = mongoose.Schema

  userId:
    type:     Object,
    required: 'Cannot send anonymous message'

  url:
    type:     String,
    required: 'Cannot send message from unknown location'

  location:
    type:     String,
    required: 'Cannot send message from unknown location'

  text:
    type:     String,
    required: '{PATH} is required'

Message = mongoose.model 'Message', messageSchema