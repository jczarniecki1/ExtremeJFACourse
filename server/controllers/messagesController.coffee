Message = require 'mongoose'
  .model 'Message'

exports.getMessages = (req, res) ->
  userId = req.params.userId
  args = if userId? then { userId: userId } else {}

  Message.find(args).exec (err, collection) ->
    res.SendIfPossible collection, err

exports.createMessage = (req, res, next) ->
  messageData = req.body

  Message.create messageData, (err, message) ->
    res.SendIfPossible message, err

exports.removeMessage = (req, res, next) ->
  id = req.params.id

  Message.remove({_id:id}).exec (err) ->
    res.SendOkIfPossible err

# TODO: answerMessage