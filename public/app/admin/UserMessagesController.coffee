angular.module 'app'
.controller 'UserMessagesController', ($scope, $routeParams, UserModel, CachedMessage, NotifierService) ->
  userId = $routeParams.userId

  UserModel.query().$promise
  .then (collection)->
    collection.findById userId, (user) ->
      $scope.user = user

  $scope.messages = CachedMessage.query {userId}

  $scope.answer = (id) ->
    $scope.messages.$promise
    .then (collection) ->
      collection.findById id, (message) ->
        answer = $scope.body.answer
        message.$answer({id, answer})
        .then ->
          NotifierService.success "Answer send successfully"
        , (error) -> NotifierService.error error

      , -> NotifierService.error "Message not found"

  $scope.delete = (id) ->
    CachedMessage.remove(id)
    ###.$promise.then (collection) ->
      for message in collection
        if message._id is id
          message.remove({id}).then ->
            NotifierService.info "Message removed successfully"
          , (error) ->
            NotifierService.error error
        return

      NotifierService.error "Message not found"
    ###