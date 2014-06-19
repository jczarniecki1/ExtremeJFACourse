angular.module 'app'
.factory 'CachedMessage', (MessageModel, $q) ->
  messageList = {}

  class CachedMessage
    query: (args) ->
      if args?.userId?
        args = { userId: args.userId }
        messageList[args.userId] ?= MessageModel.query args
      else
        messageList['all'] ?= MessageModel.query()

    answer: (userId, messageId, answer) ->
      $d = $q.defer()

      messageList[userId].$promise
      .then (collection) ->
        collection.findById messageId, (message) ->
          message.$answer {messageId, answer}
          .then ->
            collection.remove(message) and $d.resolve()
          , (response) -> $d.reject response.data.reason
        , -> $d.reject "Message not found"

      $d.promise

    remove: (userId, messageId) ->
      $d = $q.defer()

      messageList[userId].$promise
      .then (collection) ->
        collection.findById messageId, (message) ->
          message.$remove {id: messageId}
          .then ->
            collection.remove(message) and $d.resolve()
          , (response) -> $d.reject response.data.reason
        , -> $d.reject "Message not found"

      $d.promise

  new CachedMessage()