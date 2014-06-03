angular.module 'app'
.controller 'UserListController', ($scope, UserModel, NotifierService) ->
  $scope.users = UserModel.query()

  $scope.delete = (id) ->
    $scope.users.$promise
    .then (collection) ->
      collection.findById id, (user) ->
        user.$remove({id}).then ->
          NotifierService.warning "User removed successfully
                                  \nI hope you were sure to do this"
          $scope.users = UserModel.query()
        , (error) ->
          NotifierService.error error
      , -> NotifierService.error "User not found"