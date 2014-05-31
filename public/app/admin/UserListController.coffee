angular.module 'app'
  .controller 'UserListController', ($scope, UserModel, NotifierService) ->
    $scope.users = UserModel.query()

    $scope.delete = (id) ->
      $scope.users.$promise.then (collection) ->
        for user in collection
          if user._id is id
            user.$remove({id}).then ->
              NotifierService.warning "User removed successfully
                                      \nI hope you were sure to do this"
              $scope.users = UserModel.query()
            , (error) ->
              NotifierService.error error
          return

        NotifierService.error "User not found"