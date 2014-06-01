angular.module 'app'
  .factory 'MessageModel', ($resource) ->
    MessageResource = $resource '/api/user/:userId/messages/:id', {userId: "@userId", _id: "@id"},
      answer: { method: 'PUT', isArray: false }
      remove: { method: 'DELETE', isArray: false }

    MessageResource