angular.module 'app'
  .controller 'UserListController', ($scope, UserModel) ->
    $scope.users = UserModel.query()