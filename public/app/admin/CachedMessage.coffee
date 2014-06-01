angular.module 'app'
  .factory 'CachedMessage', (MessageModel, $q) ->
    messageList = {}
    {
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
          for message in collection
            if message._id is messageId
              message.$answer({messageId, answer})
              .then ->
                  collection.remove(message) and $d.resolve()
                , (response) ->
                  $d.reject response.data.reason
              return
          $d.reject "Message not found"

        $d.promise

      remove: (userId, messageId) ->
        $d = $q.defer()

        messageList[userId].$promise
        .then (collection) ->
          for message in collection
            if message._id is messageId
              message.$remove({messageId})
              .then ->
                  collection.remove(message) and $d.resolve()
                , (response) ->
                  $d.reject response.data.reason
              return
          $d.reject "Message not found"

        $d.promise
    }