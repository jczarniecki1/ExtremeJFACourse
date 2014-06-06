Message = require 'mongoose'
  .model 'Message'

exports.getMessages = (req, res) ->
  userId = req.params.userId
  args = if userId? then { userId: userId } else {}
  Message.find(args).exec (err, collection) ->
    res.send collection

exports.createMessage = (req, res, next) ->
  messageData = req.body

  Message.create messageData, (err, message) ->

    if err?
      res.status 400
      res.send
        reason: err.toString()

    else
      res.status 200
      res.send message

exports.removeMessage = (req, res, next) ->
  id = req.params.id
  Message.remove({_id:id}).exec (err) ->

    unless err?
      res.status 200
      res.end()

    else
      res.status 400
      res.send
        reason: err.toString()

# TODO: answerMessage