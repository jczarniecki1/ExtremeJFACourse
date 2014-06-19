mongoose = require 'mongoose'
Message  = mongoose.model 'Message'
User     = mongoose.model 'User'

exports.getMessages = (req, res) ->
  userId = req.params.userId
  args = if userId? then { userId: userId } else {}

  Message.find(args).exec (err, collection) ->

    User.findOne({_id:userId}).exec (err, user) ->
      user.unreadMessages = 0
      user.save()

    res.SendIfPossible collection, err


exports.createMessage = (req, res, next) ->
  messageData = req.body

  Message.create messageData, (err, message) ->
    res.SendIfPossible message, err


exports.saveFeedback = (req, res, next) ->
  messageData = req.body
  messageData.userId = req.user._id

  Message.create messageData, (err, message) ->
    if err? then return res.SendError err

    req.user.allMessages++
    req.user.unreadMessages++
    req.user.save()
    res.SendSuccess()


exports.removeMessage = (req, res, next) ->
  id = req.params.id

  Message.remove({_id:id}).exec (err) ->
    res.SendOkIfPossible err

# TODO: answerMessage